# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150809050232) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "diabetic_toolbox_achievements", force: :cascade do |t|
    t.integer  "member_id"
    t.string   "name"
    t.integer  "points"
    t.integer  "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "diabetic_toolbox_achievements", ["member_id"], name: "index_diabetic_toolbox_achievements_on_member_id", using: :btree

  create_table "diabetic_toolbox_ingredients", force: :cascade do |t|
    t.integer  "recipe_id"
    t.string   "name"
    t.float    "volume"
    t.integer  "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "diabetic_toolbox_ingredients", ["recipe_id"], name: "index_diabetic_toolbox_ingredients_on_recipe_id", using: :btree

  create_table "diabetic_toolbox_members", force: :cascade do |t|
    t.string   "first_name",               default: "", null: false
    t.string   "last_name",                default: "", null: false
    t.string   "username",                 default: "", null: false
    t.string   "slug",                     default: "", null: false
    t.string   "email",                    default: "", null: false
    t.string   "encrypted_password",       default: "", null: false
    t.string   "encryption_salt",          default: "", null: false
    t.string   "session_token"
    t.date     "dob"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remembered_at"
    t.datetime "current_session_began_at"
    t.datetime "last_session_began_at"
    t.string   "current_session_ip"
    t.string   "last_session_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts"
    t.string   "unlock_token"
    t.datetime "last_locked_at"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "diabetic_toolbox_members", ["confirmation_token"], name: "index_diabetic_toolbox_members_on_confirmation_token", unique: true, using: :btree
  add_index "diabetic_toolbox_members", ["email"], name: "index_diabetic_toolbox_members_on_email", unique: true, using: :btree
  add_index "diabetic_toolbox_members", ["reset_password_token"], name: "index_diabetic_toolbox_members_on_reset_password_token", unique: true, using: :btree
  add_index "diabetic_toolbox_members", ["session_token"], name: "index_diabetic_toolbox_members_on_session_token", unique: true, using: :btree
  add_index "diabetic_toolbox_members", ["slug"], name: "index_diabetic_toolbox_members_on_slug", unique: true, using: :btree
  add_index "diabetic_toolbox_members", ["unlock_token"], name: "index_diabetic_toolbox_members_on_unlock_token", unique: true, using: :btree

  create_table "diabetic_toolbox_readings", force: :cascade do |t|
    t.integer  "member_id"
    t.float    "glucometer_value"
    t.datetime "test_time"
    t.integer  "meal"
    t.integer  "intake"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "diabetic_toolbox_readings", ["glucometer_value"], name: "index_diabetic_toolbox_readings_on_glucometer_value", using: :btree
  add_index "diabetic_toolbox_readings", ["meal"], name: "index_diabetic_toolbox_readings_on_meal", using: :btree
  add_index "diabetic_toolbox_readings", ["member_id"], name: "index_diabetic_toolbox_readings_on_member_id", using: :btree
  add_index "diabetic_toolbox_readings", ["test_time"], name: "index_diabetic_toolbox_readings_on_test_time", using: :btree

  create_table "diabetic_toolbox_recipes", force: :cascade do |t|
    t.integer  "member_id"
    t.string   "name"
    t.integer  "servings"
    t.integer  "grams_carbohydrate_per_serving"
    t.integer  "calories_per_serving"
    t.integer  "grams_fat_per_serving"
    t.integer  "grams_protein_per_serving"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "diabetic_toolbox_recipes", ["member_id"], name: "index_diabetic_toolbox_recipes_on_member_id", using: :btree

  create_table "diabetic_toolbox_report_configurations", force: :cascade do |t|
    t.integer  "member_id"
    t.string   "name"
    t.integer  "period"
    t.date     "from"
    t.date     "to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "diabetic_toolbox_report_configurations", ["member_id"], name: "index_diabetic_toolbox_report_configurations_on_member_id", using: :btree

  create_table "diabetic_toolbox_reports", force: :cascade do |t|
    t.integer  "member_id"
    t.string   "name"
    t.datetime "coverage_start"
    t.datetime "coverage_end"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "report_document_file_name"
    t.string   "report_document_content_type"
    t.integer  "report_document_file_size"
    t.datetime "report_document_updated_at"
  end

  add_index "diabetic_toolbox_reports", ["member_id"], name: "index_diabetic_toolbox_reports_on_member_id", using: :btree

  create_table "diabetic_toolbox_settings", force: :cascade do |t|
    t.integer  "member_id"
    t.integer  "intake_ratio"
    t.float    "correction_base"
    t.integer  "increments_by"
    t.integer  "ll_units_per_day"
    t.integer  "glucometer_measure_type"
    t.integer  "intake_measure_type"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "diabetic_toolbox_settings", ["glucometer_measure_type"], name: "index_diabetic_toolbox_settings_on_glucometer_measure_type", using: :btree
  add_index "diabetic_toolbox_settings", ["intake_measure_type"], name: "index_diabetic_toolbox_settings_on_intake_measure_type", using: :btree
  add_index "diabetic_toolbox_settings", ["member_id"], name: "index_diabetic_toolbox_settings_on_member_id", using: :btree

  create_table "diabetic_toolbox_steps", force: :cascade do |t|
    t.integer  "recipe_id"
    t.string   "description"
    t.integer  "order"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "diabetic_toolbox_steps", ["recipe_id"], name: "index_diabetic_toolbox_steps_on_recipe_id", using: :btree

  create_table "diabetic_toolbox_votes", force: :cascade do |t|
    t.boolean  "vote",          default: false, null: false
    t.integer  "voteable_id",                   null: false
    t.string   "voteable_type",                 null: false
    t.integer  "voter_id"
    t.string   "voter_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "diabetic_toolbox_votes", ["voteable_id", "voteable_type"], name: "index_diabetic_toolbox_votes_on_voteable_id_and_voteable_type", using: :btree
  add_index "diabetic_toolbox_votes", ["voter_id", "voter_type", "voteable_id", "voteable_type"], name: "fk_one_vote_per_member", unique: true, using: :btree
  add_index "diabetic_toolbox_votes", ["voter_id", "voter_type"], name: "index_diabetic_toolbox_votes_on_voter_id_and_voter_type", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

end