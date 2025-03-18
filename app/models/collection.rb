class Collection < ApplicationRecord
  belongs_to :user

  has_many :saved_restaurants_collections
  has_many :saved_restaurants, through: :saved_restaurants_collections
  has_many :restaurants, through: :saved_restaurants

  validates :name, presence: true, uniqueness: { scope: :user_id, message: "You already have a collection with this name" }
  validates :color, presence: true
  validates :emoji, presence: true
end
