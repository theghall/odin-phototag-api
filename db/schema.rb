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

ActiveRecord::Schema.define(version: 2018_06_25_024520) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.text "access_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["access_token"], name: "index_api_keys_on_access_token", unique: true
  end

  create_table "items", force: :cascade do |t|
    t.bigint "photo_id"
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["photo_id"], name: "index_items_on_photo_id"
  end

  create_table "leaderboards", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "levels", force: :cascade do |t|
    t.bigint "leaderboard_id"
    t.text "difficulty"
    t.float "best_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["leaderboard_id"], name: "index_levels_on_leaderboard_id"
  end

  create_table "locations", force: :cascade do |t|
    t.bigint "item_id"
    t.text "bottom_left_loc"
    t.text "top_left_loc"
    t.text "top_right_loc"
    t.text "bottom_right_loc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_locations_on_item_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string "name"
    t.string "desc"
    t.string "difficulty"
    t.string "category"
    t.string "image_filename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_photos_on_category"
    t.index ["difficulty"], name: "index_photos_on_difficulty"
    t.index ["name"], name: "index_photos_on_name", unique: true
  end

  add_foreign_key "items", "photos"
  add_foreign_key "levels", "leaderboards"
  add_foreign_key "locations", "items"
end
