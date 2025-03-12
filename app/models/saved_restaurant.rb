class SavedRestaurant < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user
  has_many :collections, through: :saved_restaurants_collections
end
