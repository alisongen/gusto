class CreateSavedRestaurantsCollections < ActiveRecord::Migration[7.1]
  def change
    create_table :saved_restaurants_collections do |t|
      t.references :saved_restaurant, null: false, foreign_key: true
      t.references :collection, null: false, foreign_key: true

      t.timestamps
    end
  end
end
