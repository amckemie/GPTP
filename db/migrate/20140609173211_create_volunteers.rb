class CreateVolunteers < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|
      t.string :name, null: false
      t.string :password, null: false
      t.integer :age
      t.string :email, null: false
    end
    add_index :volunteers, :name
  end
end
