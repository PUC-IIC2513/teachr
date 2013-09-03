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

ActiveRecord::Schema.define(version: 20130903155450) do

  create_table "announcements", force: true do |t|
    t.string   "title",                     null: false
    t.text     "content"
    t.integer  "level",      default: 1
    t.boolean  "notify",     default: true
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "announcements", ["user_id"], name: "index_announcements_on_user_id"

  create_table "resources", force: true do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.string   "file"
    t.string   "url"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resources", ["user_id"], name: "index_resources_on_user_id"

  create_table "resources_tags", force: true do |t|
    t.integer "resource_id"
    t.integer "tag_id"
    t.integer "user_id"
  end

  add_index "resources_tags", ["resource_id", "tag_id"], name: "index_resources_tags_on_resource_id_and_tag_id", unique: true
  add_index "resources_tags", ["user_id"], name: "index_resources_tags_on_user_id"

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "users", force: true do |t|
    t.string   "first_name", limit: 100,                     null: false
    t.string   "last_name",  limit: 100,                     null: false
    t.string   "email",      limit: 200,                     null: false
    t.string   "password",   limit: 50,                      null: false
    t.string   "role",                   default: "student"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
