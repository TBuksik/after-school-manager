class CreateEnrollments < ActiveRecord::Migration[8.1]
  def change
    create_table :enrollments do |t|
      t.references :student, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.datetime :enrolled_at, null: false, default: -> { "CURRENT_TIMESTAMP" }

      t.timestamps
    end

    add_index :enrollments, [ :student_id, :group_id ],
              unique: true,
              where: "status = 0",
              name: "index_enrollments_on_active_student_and_group"
  end
end
