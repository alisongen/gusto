class Collection < ApplicationRecord
  belongs_to :user

  has_many :saved_restaurants_collections
  has_many :saved_restaurants, through: :saved_restaurants_collections
  has_many :restaurants, through: :saved_restaurants

  validates :color, presence: true
  validates :emoji, presence: true
end
