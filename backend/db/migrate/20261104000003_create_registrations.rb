class CreateRegistrations < ActiveRecord::Migration[7.1]
  def change
    create_table :registrations do |t|
      t.references :course, null: false, foreign_key: true
      t.string :key_number, null: false
      t.string :full_name, null: false
      t.string :email
      t.string :status, default: "confirmed", null: false
      t.string :ledger_hash

      t.timestamps
    end

    # Enforce strict relational uniqueness to prevent duplicate registrations at the database level
    add_index :registrations, [:course_id, :key_number], unique: true
    add_index :registrations, :key_number
  end
end

