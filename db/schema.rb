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

ActiveRecord::Schema.define(version: 20150413180700) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calls", force: :cascade do |t|
    t.integer  "event_id",    null: false
    t.integer  "position_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "description"
    t.datetime "start_time",  null: false
    t.datetime "end_time",    null: false
    t.integer  "venue_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offers", force: :cascade do |t|
    t.integer "call_id"
    t.integer "user_id"
    t.boolean "available"
    t.integer "event_id",  null: false
  end

  create_table "positions", force: :cascade do |t|
    t.string   "name",                       null: false
    t.integer  "pay_rate_cents", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timecards", force: :cascade do |t|
    t.datetime "clock_in"
    t.datetime "clock_out"
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.string   "first_name",                             null: false
    t.string   "last_name",                              null: false
    t.string   "street_address",                         null: false
    t.string   "street_address_2"
    t.string   "city",                                   null: false
    t.string   "state",                                  null: false
    t.string   "zip_code",                               null: false
    t.string   "phone",                                  null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "name",             null: false
    t.string   "street_address"
    t.string   "street_address_2"
    t.string   "city",             null: false
    t.string   "state",            null: false
    t.string   "zip_code"
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
