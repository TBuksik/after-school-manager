class CreateGroups < ActiveRecord::Migration[8.1]
  def change
    create_table :groups do |t|
      t.references :course, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :capacity, null: false

      t.timestamps
    end

    add_check_constraint :groups, "capacity > 0", name: "groups_capacity_positive"
  end
end
