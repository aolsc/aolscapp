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

ActiveRecord::Schema.define(:version => 20111028082033) do

  create_table "centers", :force => true do |t|
    t.string "city"
    t.string "state"
    t.string "country"
  end

  create_table "communication_subscriptions", :force => true do |t|
    t.string "center_id"
    t.string "member_id"
  end

  create_table "course_schedules", :force => true do |t|
    t.integer  "course_id"
    t.string   "displayname"
    t.integer  "center_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "location_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "volunteer_id"
    t.integer  "teacher_id"
    t.integer  "last_updated_by"
    t.integer  "volunteer_id2"
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "displayName"
    t.string   "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_files", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "member_attendances", :force => true do |t|
    t.integer  "member_id"
    t.date     "checkin_date"
    t.integer  "volunteer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_schedule_id"
    t.integer  "center_id"
  end

  create_table "member_course_interests", :force => true do |t|
    t.integer  "member_id"
    t.integer  "course_id"
    t.date     "interest_date"
    t.string   "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "member_courses", :force => true do |t|
    t.integer  "member_id"
    t.integer  "course_schedule_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "referral_source"
    t.integer  "last_updated_by"
  end

  create_table "member_general_feedbacks", :force => true do |t|
    t.integer  "member_id"
    t.string   "feedback"
    t.date     "feedback_date"
    t.string   "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "member_notes", :force => true do |t|
    t.string   "note"
    t.string   "member_id"
    t.string   "added_by"
    t.datetime "created_at"
  end

  create_table "member_taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "member_id"
    t.datetime "created_at"
    t.integer  "created_by"
  end

  add_index "member_taggings", ["tag_id"], :name => "index_member_taggings_on_tag_id"

  create_table "members", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "emailid"
    t.string   "emailsubscribe"
    t.string   "updateby"
    t.string   "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gender"
    t.string   "agetype"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.string   "homephone"
    t.string   "cellphone"
    t.string   "employer"
    t.string   "profession"
    t.boolean  "taken_course"
    t.integer  "center_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "role_name"
    t.string   "updateby"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.integer  "center_id"
    t.datetime "created_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "memberid"
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "updateby"
    t.datetime "updatedate"
    t.string   "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "member_id"
  end

end
