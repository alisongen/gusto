class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :reviews
  has_many :collections
  has_many :saved_restaurants
  has_many :restaurants, through: :saved_restaurants

  def friends
    all_accepted_friendships = Friendship.where(status: 1).where(user: self).or(Friendship.where(status: 1).where(friend: self))
    # Sortir les id de ceux-là
    ids = all_accepted_friendships.map do |friendship|
      if friendship.user == self
        friendship.friend.id
      else
        friendship.user.id
      end
    end
    return User.where(id: ids)
  end

  def friends_restaurants
    friends = self.friends.pluck(:id)
    restaurant_ids = SavedRestaurant.where(user_id: friends).pluck(:restaurant_id)
    Restaurant.where(id: restaurant_ids)
  end
end
