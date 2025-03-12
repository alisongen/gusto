class SavedRestaurant < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user

  has_many_attached :photos
  has_many :saved_restaurants_collections
  has_many :collections, through: :saved_restaurants_collections
end
