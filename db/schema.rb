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

ActiveRecord::Schema.define(version: 20180701022750) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cups", force: :cascade do |t|
    t.string   "name"
    t.string   "host"
    t.string   "logo"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "result_id"
    t.integer  "match_fee"
    t.float    "reward_percent"
    t.integer  "knockout_match_fee"
    t.integer  "save_reward"
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "team1_id"
    t.integer  "team2_id"
    t.integer  "mainscore1"
    t.integer  "mainscore2"
    t.integer  "subscore1"
    t.integer  "subscore2"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "status",     default: false
    t.datetime "time"
    t.integer  "cup_id",     default: 1
    t.boolean  "knockout"
    t.float    "prior1"
    t.float    "prior2"
  end

  add_index "matches", ["cup_id"], name: "index_matches_on_cup_id", using: :btree

  create_table "predictions", force: :cascade do |t|
    t.integer  "match_id"
    t.integer  "user_id"
    t.integer  "mainscore1"
    t.integer  "mainscore2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "cup_id"
    t.integer  "reward"
  end

  add_index "predictions", ["cup_id"], name: "index_predictions_on_cup_id", using: :btree
  add_index "predictions", ["match_id"], name: "index_predictions_on_match_id", using: :btree
  add_index "predictions", ["user_id"], name: "index_predictions_on_user_id", using: :btree

  create_table "scores", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "cup_id"
    t.integer  "score"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "reward"
    t.integer  "knockout_reward"
  end

  add_index "scores", ["cup_id"], name: "index_scores_on_cup_id", using: :btree
  add_index "scores", ["user_id"], name: "index_scores_on_user_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "score"
    t.string   "coach"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "status",               default: true
    t.integer  "cup_id",               default: 1
    t.string   "cup_group",  limit: 1
  end

  add_index "teams", ["cup_id"], name: "index_teams_on_cup_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "matches", "cups"
  add_foreign_key "predictions", "cups"
  add_foreign_key "predictions", "matches"
  add_foreign_key "predictions", "users"
  add_foreign_key "scores", "cups"
  add_foreign_key "scores", "users"
  add_foreign_key "teams", "cups"
end
