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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130309221545) do

  create_table "items", :force => true do |t|
    t.string   "content"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "user_id"
    t.integer  "school_id"
    t.integer  "counter",    :default => 0
    t.integer  "voters"
  end

  create_table "reactions", :force => true do |t|
    t.string   "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "item_id"
    t.integer  "user_id"
  end

  add_index "reactions", ["comment"], :name => "index_reactions_on_comment"

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "schools", ["name"], :name => "index_schools_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.integer  "school_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["school_id"], :name => "index_users_on_school_id"

  create_table "wants", :force => true do |t|
    t.integer  "user_id"
    t.string   "item_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "wants", ["item_id"], :name => "index_wants_on_item_id"
  add_index "wants", ["user_id"], :name => "index_wants_on_user_id"

end
