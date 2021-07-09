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

ActiveRecord::Schema.define(version: 20210709144029) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cups", force: :cascade do |t|
    t.string   "name"
    t.string   "host"
    t.string   "logo"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "result_id"
    t.float    "reward_percent"
    t.integer  "save_reward"
  end

# Could not dump table "matches" because of following FrozenError
#   can't modify frozen String: "false"

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
    t.integer  "knockout_fee"
  end

  add_index "scores", ["cup_id"], name: "index_scores_on_cup_id", using: :btree
  add_index "scores", ["user_id"], name: "index_scores_on_user_id", using: :btree

# Could not dump table "teams" because of following FrozenError
#   can't modify frozen String: "true"

# Could not dump table "users" because of following FrozenError
#   can't modify frozen String: "false"

  add_foreign_key "matches", "cups"
  add_foreign_key "predictions", "cups"
  add_foreign_key "predictions", "matches"
  add_foreign_key "predictions", "users"
  add_foreign_key "scores", "cups"
  add_foreign_key "scores", "users"
  add_foreign_key "teams", "cups"
end
