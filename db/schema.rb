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

ActiveRecord::Schema.define(version: 20151205144023) do

  create_table "applies", force: :cascade do |t|
    t.integer  "leave_type",       limit: 4
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "replace_person",   limit: 4
    t.text     "address_on_leave", limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "employee_id",      limit: 4
    t.string   "status",           limit: 255
    t.integer  "no_day",           limit: 4
    t.integer  "dept",             limit: 4
  end

  create_table "departments", force: :cascade do |t|
    t.string   "dept",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "ic",              limit: 255
    t.text     "address",         limit: 65535
    t.string   "phone",           limit: 255
    t.string   "position",        limit: 255
    t.string   "email",           limit: 255
    t.integer  "dept",            limit: 4
    t.date     "startdate"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "hashed_password", limit: 255
    t.string   "employeeid",      limit: 255
    t.integer  "annualleave",     limit: 4
    t.integer  "medicalleave",    limit: 4
    t.integer  "compasleave",     limit: 4
    t.integer  "maternityleave",  limit: 4
    t.string   "gender",          limit: 255
  end

  create_table "leavetypes", force: :cascade do |t|
    t.text     "ltype",      limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "managers", force: :cascade do |t|
    t.integer  "employee_id", limit: 4
    t.integer  "dept_id",     limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255,   null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.string   "hashed_password", limit: 255
    t.string   "salt",            limit: 255
    t.integer  "user_level_id",   limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end
