class AddPennyDate < ActiveRecord::Migration
  def change
    add_column :pennies, :date, :string
  end
end
