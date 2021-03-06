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

ActiveRecord::Schema.define(:version => 20130311220009) do

  create_table "items", :force => true do |t|
    t.string   "content"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "user_id"
    t.integer  "school_id"
    t.integer  "counter",    :default => 0
    t.integer  "voters"
  end

  create_table "personals", :force => true do |t|
    t.integer  "want_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "content"
    t.integer  "user_id"
  end

  add_index "personals", ["want_id"], :name => "index_personals_on_want_id"

  create_table "reactions", :force => true do |t|
    t.string   "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "item_id"
    t.integer  "user_id"
  end

  add_index "reactions", ["comment"], :name => "index_reactions_on_comment"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "schools", ["name"], :name => "index_schools_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.integer  "school_id"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["school_id"], :name => "index_users_on_school_id"

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "votes", ["item_id"], :name => "index_votes_on_item_id"
  add_index "votes", ["user_id", "item_id"], :name => "index_votes_on_user_id_and_item_id", :unique => true
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

  create_table "wants", :force => true do |t|
    t.integer  "user_id"
    t.string   "item_id"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "status",               :default => 0
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  add_index "wants", ["item_id"], :name => "index_wants_on_item_id"
  add_index "wants", ["user_id", "item_id"], :name => "index_wants_on_user_id_and_item_id", :unique => true
  add_index "wants", ["user_id"], :name => "index_wants_on_user_id"

end
