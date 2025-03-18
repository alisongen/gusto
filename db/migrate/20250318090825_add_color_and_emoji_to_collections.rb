class AddColorAndEmojiToCollections < ActiveRecord::Migration[7.1]
  def change
    add_column :collections, :color, :string
    add_column :collections, :emoji, :string
  end
end
