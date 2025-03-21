class Restaurant < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_name,
  against: :name,
  using: {
    tsearch: { prefix: true } # <-- now `superman batm` will return something!
  }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  has_many :saved_restaurants, dependent: :destroy
  has_many_attached :images
end
