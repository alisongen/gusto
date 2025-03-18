class Review < ApplicationRecord
  belongs_to :user
  belongs_to :saved_restaurant

  has_one :restaurant, through: :saved_restaurants
end
