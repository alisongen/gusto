class RemoveSavedRestaurantFromCollections < ActiveRecord::Migration[7.1]
  def change
    remove_reference :collections, :saved_restaurant, null: false, foreign_key: true
  end
end
