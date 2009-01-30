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

<<<<<<< HEAD:db/schema.rb
ActiveRecord::Schema.define(:version => 20090127095036) do
=======
ActiveRecord::Schema.define(:version => 20090117101343) do
>>>>>>> d23cadc789f204faec6630f118a857c796588582:Admin Module/db/schema.rb

  create_table "actions", :force => true do |t|
    t.text     "action",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admins", :force => true do |t|
    t.string   "username",        :limit => 40, :null => false
    t.string   "hashed_password",               :null => false
    t.string   "salt",                          :null => false
    t.string   "last_name",                     :null => false
    t.string   "first_name",                    :null => false
    t.string   "position",                      :null => false
    t.boolean  "active",                        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "email"
    t.datetime "last_visit"
  end

  create_table "announcements", :force => true do |t|
    t.datetime "date_time",    :null => false
    t.text     "announcement", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "summary"
  end

  create_table "asessions", :force => true do |t|
    t.string   "ip_add",     :null => false
    t.datetime "time_out",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campus_activities", :force => true do |t|
    t.datetime "date",       :null => false
    t.text     "activity",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "summary"
  end

  create_table "followers", :force => true do |t|
    t.integer  "idno"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", :force => true do |t|
    t.string   "idno"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.datetime "last_login"
    t.datetime "cur_login"
  end

  create_table "violations", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
