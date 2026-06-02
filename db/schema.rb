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

ActiveRecord::Schema[8.0].define(version: 2026_06_02_192146) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "candidates", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.date "dob"
    t.string "pan_number"
    t.string "aadhaar_number"
    t.text "address"
    t.string "city"
    t.string "state"
    t.string "pincode"
    t.index ["email"], name: "index_candidates_on_email", unique: true
    t.index ["reset_password_token"], name: "index_candidates_on_reset_password_token", unique: true
  end

  create_table "education_histories", force: :cascade do |t|
    t.bigint "candidate_id", null: false
    t.string "institution_name"
    t.string "degree"
    t.string "field_of_study"
    t.integer "graduation_year"
    t.boolean "verified"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_education_histories_on_candidate_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.text "address"
    t.string "website"
    t.string "logo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "verification_cases", force: :cascade do |t|
    t.bigint "candidate_id", null: false
    t.bigint "organization_id", null: false
    t.string "status"
    t.string "token"
    t.datetime "requested_at"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_verification_cases_on_candidate_id"
    t.index ["organization_id"], name: "index_verification_cases_on_organization_id"
    t.index ["token"], name: "index_verification_cases_on_token"
  end

  create_table "work_histories", force: :cascade do |t|
    t.bigint "candidate_id", null: false
    t.string "company_name"
    t.string "job_title"
    t.date "start_date"
    t.date "end_date"
    t.boolean "current_job"
    t.string "location"
    t.text "description"
    t.boolean "verified"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_work_histories_on_candidate_id"
  end

  add_foreign_key "education_histories", "candidates"
  add_foreign_key "verification_cases", "candidates"
  add_foreign_key "verification_cases", "organizations"
  add_foreign_key "work_histories", "candidates"
end
