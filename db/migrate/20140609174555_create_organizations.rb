class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :password, null: false
      t.string :description
      t.string :address
      t.string :email, null: false
      t.integer :phone_num
    end
    add_index :organizations, :email
  end
end
