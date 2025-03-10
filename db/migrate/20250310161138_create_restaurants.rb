class CreateRestaurants < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.text :description
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :category
      t.string :menu
      t.float :rating
      t.integer :phone_number
      t.string :website

      t.timestamps
    end
  end
end
