class RemoveCollectionFromSavedRestaurant < ActiveRecord::Migration[7.1]
  def change
    remove_column :saved_restaurants, :collection, :string
  end
end
