class ChangePhoneNumberToString < ActiveRecord::Migration[7.1]
  def change
    change_column :restaurants, :phone_number, :string
  end
end
