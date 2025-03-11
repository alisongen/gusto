class CreateSavedRestaurants < ActiveRecord::Migration[7.1]
  def change
    create_table :saved_restaurants do |t|
      t.references :user, null: false, foreign_key: true
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
