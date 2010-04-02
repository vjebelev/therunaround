# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090510030152) do

  create_table "runs", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.date     "date"
    t.integer  "miles"
    t.string   "route"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "runs", ["user_id"], :name => "index_runs_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username",                                :null => false
    t.string   "name",                                    :null => false
    t.string   "password"
    t.string   "email"
    t.integer  "fb_uid",                   :default => 0
    t.string   "email_hash", :limit => 64
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["username"], :name => "index_users_on_username"

end
