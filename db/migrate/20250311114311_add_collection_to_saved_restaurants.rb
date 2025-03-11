class AddCollectionToSavedRestaurants < ActiveRecord::Migration[7.1]
  def change
    add_column :saved_restaurants, :collection, :string
  end
end
