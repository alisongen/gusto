class SavedRestaurantsCollection < ApplicationRecord
  belongs_to :saved_restaurant
  belongs_to :collection
end
