class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.string :course_code, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.datetime :registration_deadline, null: false
      t.string :department, default: "Dept. of Computer Science"
      t.string :cohort, default: "Cohort: Q4 2026"
      t.references :admin, null: false, foreign_key: true

      t.timestamps
    end

    add_index :courses, :course_code, unique: true
  end
end

