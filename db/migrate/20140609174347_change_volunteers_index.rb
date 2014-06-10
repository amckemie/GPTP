class ChangeVolunteersIndex < ActiveRecord::Migration
  def change
    remove_index :volunteers, :name
    add_index :volunteers, :email
  end
end
