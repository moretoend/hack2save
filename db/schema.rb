# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170711213617) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "complaints", force: :cascade do |t|
    t.bigint "denunciable_id"
    t.integer "denunciable_type"
    t.string "reason"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["denunciable_id"], name: "index_complaints_on_denunciable_id"
  end

  create_table "institution_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "institution_id"
    t.integer "permission"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_id"], name: "index_institution_users_on_institution_id"
    t.index ["user_id"], name: "index_institution_users_on_user_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.boolean "requirements", default: false
    t.text "requirements_description"
    t.bigint "institution_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_id"], name: "index_jobs_on_institution_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "reviewable_id"
    t.integer "reviewable_type"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reviewable_id"], name: "index_reviews_on_reviewable_id"
  end

  create_table "user_jobs", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "job_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_user_jobs_on_job_id"
    t.index ["user_id"], name: "index_user_jobs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "complaints", "users", column: "denunciable_id"
  add_foreign_key "institution_users", "institutions"
  add_foreign_key "institution_users", "users"
  add_foreign_key "jobs", "institutions"
  add_foreign_key "reviews", "users", column: "reviewable_id"
  add_foreign_key "user_jobs", "jobs"
  add_foreign_key "user_jobs", "users"
end
