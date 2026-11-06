# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2026_11_04_000003) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", null: false
    t.string "name", default: "Registrar Officer"
    t.string "role", default: "registrar"
    t.string "otp_digest"
    t.datetime "otp_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "courses", force: :cascade do |t|
    t.string "name", null: false
    t.string "course_code", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.datetime "registration_deadline", null: false
    t.string "department", default: "Dept. of Computer Science"
    t.string "cohort", default: "Cohort: Q4 2026"
    t.bigint "admin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_courses_on_admin_id"
    t.index ["course_code"], name: "index_courses_on_course_code", unique: true
  end

  create_table "registrations", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.string "key_number", null: false
    t.string "full_name", null: false
    t.string "email"
    t.string "status", default: "confirmed", null: false
    t.string "ledger_hash"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id", "key_number"], name: "index_registrations_on_course_id_and_key_number", unique: true
    t.index ["course_id"], name: "index_registrations_on_course_id"
    t.index ["key_number"], name: "index_registrations_on_key_number"
  end

  add_foreign_key "courses", "admins"
  add_foreign_key "registrations", "courses"
end
