class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.float :user_rating
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :saved_restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
