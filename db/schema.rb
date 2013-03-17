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

ActiveRecord::Schema.define(:version => 20130312160456) do

  create_table "admins", :id => false, :force => true do |t|
    t.integer "org_id"
    t.integer "user_id"
    t.boolean "admin"
  end

  add_index "admins", ["org_id", "user_id"], :name => "index_admins_on_org_id_and_user_id"

  create_table "orgs", :force => true do |t|
    t.string   "name"
    t.string   "country"
    t.string   "city"
    t.string   "phone"
    t.string   "email"
    t.date     "entry_date"
    t.date     "last_update"
    t.text     "note"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.boolean  "siteadmin"
    t.string   "username"
    t.string   "pw"
    t.string   "email"
    t.string   "phone"
    t.date     "last_login"
    t.date     "entry_date"
    t.text     "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "first"
    t.string   "last"
    t.string   "salt"
  end

  create_table "users_orgs", :force => true do |t|
    t.integer "user_id"
    t.integer "org_id"
  end

end
