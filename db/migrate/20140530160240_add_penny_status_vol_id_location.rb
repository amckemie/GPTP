class AddPennyStatusVolIdLocation < ActiveRecord::Migration
  def change
    add_column :pennies, :location, :string
    add_column :pennies, :status, :integer, default: 0
    add_column :pennies, :vol_id, :integer
  end
end
