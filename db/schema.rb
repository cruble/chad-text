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

ActiveRecord::Schema.define(version: 20160116205445) do

  create_table "game_benches", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "game_benches", ["game_id"], name: "index_game_benches_on_game_id"
  add_index "game_benches", ["user_id"], name: "index_game_benches_on_user_id"

  create_table "game_players", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "game_players", ["game_id"], name: "index_game_players_on_game_id"
  add_index "game_players", ["user_id"], name: "index_game_players_on_user_id"

  create_table "games", force: :cascade do |t|
    t.date     "game_date"
    t.string   "opponent"
    t.string   "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "season_id"
    t.string   "status"
  end

  add_index "games", ["season_id"], name: "index_games_on_season_id"

  create_table "player_season_bencheds", force: :cascade do |t|
    t.integer  "season_id"
    t.integer  "user_id"
    t.integer  "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "player_season_bencheds", ["season_id"], name: "index_player_season_bencheds_on_season_id"
  add_index "player_season_bencheds", ["user_id"], name: "index_player_season_bencheds_on_user_id"

  create_table "player_season_playeds", force: :cascade do |t|
    t.integer  "season_id"
    t.integer  "user_id"
    t.integer  "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "player_season_playeds", ["season_id"], name: "index_player_season_playeds_on_season_id"
  add_index "player_season_playeds", ["user_id"], name: "index_player_season_playeds_on_user_id"

  create_table "season_player_bencheds", force: :cascade do |t|
    t.integer "season_id"
    t.integer "user_id"
    t.integer "count"
  end

  add_index "season_player_bencheds", ["season_id"], name: "index_season_player_bencheds_on_season_id"
  add_index "season_player_bencheds", ["user_id"], name: "index_season_player_bencheds_on_user_id"

  create_table "season_player_playeds", force: :cascade do |t|
    t.integer "season_id"
    t.integer "user_id"
    t.integer "count"
  end

  add_index "season_player_playeds", ["season_id"], name: "index_season_player_playeds_on_season_id"
  add_index "season_player_playeds", ["user_id"], name: "index_season_player_playeds_on_user_id"

  create_table "seasons", force: :cascade do |t|
    t.string   "name"
    t.boolean  "is_current"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "phone"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
