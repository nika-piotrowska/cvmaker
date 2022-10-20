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

ActiveRecord::Schema.define(version: 2022_10_20_182451) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "certificates", force: :cascade do |t|
    t.bigint "section_id"
    t.string "name", null: false
    t.date "date"
    t.text "description"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["section_id"], name: "index_certificates_on_section_id"
  end

  create_table "courses", force: :cascade do |t|
    t.bigint "section_id"
    t.string "name", null: false
    t.string "institution", null: false
    t.date "start_date", null: false
    t.date "end_date"
    t.text "description"
    t.integer "position", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["section_id"], name: "index_courses_on_section_id"
  end

  create_table "cvs", force: :cascade do |t|
    t.bigint "user_id"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "phone_number", null: false
    t.string "address"
    t.string "drivers_licence"
    t.string "linkedin"
    t.string "facebook"
    t.string "twitter"
    t.string "instagram"
    t.string "github"
    t.string "website"
    t.date "birth_date", null: false
    t.integer "sex", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_cvs_on_user_id"
  end

  create_table "educations", force: :cascade do |t|
    t.bigint "section_id"
    t.string "level", null: false
    t.string "city"
    t.string "university", null: false
    t.string "faculty"
    t.string "specialisation"
    t.date "start_date", null: false
    t.date "end_date"
    t.integer "position", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["section_id"], name: "index_educations_on_section_id"
  end

  create_table "employments", force: :cascade do |t|
    t.bigint "section_id"
    t.string "name", null: false
    t.string "city"
    t.string "employer", null: false
    t.date "start_date", null: false
    t.date "end_date"
    t.text "description"
    t.integer "position", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["section_id"], name: "index_employments_on_section_id"
  end

  create_table "languages", force: :cascade do |t|
    t.bigint "section_id"
    t.string "language"
    t.integer "language_level", default: 0, null: false
    t.integer "position", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["section_id"], name: "index_languages_on_section_id"
  end

  create_table "references", force: :cascade do |t|
    t.bigint "section_id"
    t.string "company", null: false
    t.string "contact_person"
    t.bigint "phone_number"
    t.string "email"
    t.text "description"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["section_id"], name: "index_references_on_section_id"
  end

  create_table "sections", force: :cascade do |t|
    t.bigint "cv_id"
    t.integer "name", default: 0, null: false
    t.string "custom_name"
    t.text "content"
    t.integer "position", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cv_id"], name: "index_sections_on_cv_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
