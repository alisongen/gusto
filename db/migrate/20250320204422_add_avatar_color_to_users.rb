class AddAvatarColorToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :avatar_color, :string
  end
end
