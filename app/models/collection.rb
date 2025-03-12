class Collection < ApplicationRecord
  belongs_to :user
  has_many :saved_restaurants_collections
end
