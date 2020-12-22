# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_06_234015) do

  create_table "employee_timesheets", force: :cascade do |t|
    t.date "date"
    t.date "biweekly_start_date"
    t.date "biweekly_end_date"
    t.float "hours_worked"
    t.integer "employee_id"
    t.string "job_group"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "time_reports", force: :cascade do |t|
    t.string "time_report_name"
    t.integer "time_report_id"
    t.string "time_report_upload_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
