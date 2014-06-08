class CreatePenny < ActiveRecord::Migration
  def change
    create_table :pennies do |t|
      t.string :name
      t.text :description
      t.integer :org_id
      t.string :time_requirement
      t.string :time
    end
  end
end
