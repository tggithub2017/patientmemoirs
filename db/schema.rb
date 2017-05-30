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

ActiveRecord::Schema.define(version: 20170529031816) do

  create_table "admin_specialists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "staff_profile_id"
    t.string   "title"
    t.text     "description",      limit: 65535
    t.text     "detail",           limit: 65535
    t.string   "image"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "authcons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
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
    t.string   "usertype"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_authcons_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_authcons_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_authcons_on_reset_password_token", unique: true, using: :btree
  end

  create_table "blog_posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "account_id",                null: false
    t.string   "title"
    t.text     "description", limit: 65535
    t.text     "detail",      limit: 65535, null: false
    t.text     "image",       limit: 65535
    t.text     "image1",      limit: 65535
    t.text     "image2",      limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "fusers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "gusers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "patient_profile_id"
    t.integer  "staff_profile_id"
    t.integer  "send_to",            null: false
    t.string   "content"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "patient_profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "authcons_id"
    t.integer  "fusers_id"
    t.integer  "allowed"
    t.string   "image"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "sex"
    t.string   "birthdate"
    t.string   "email"
    t.string   "phone_number"
    t.string   "nhs_number",                            null: false
    t.string   "address"
    t.string   "healthcare_professional"
    t.string   "lead_clinician"
    t.string   "occupation"
    t.text     "detail",                  limit: 65535
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "patient_vrds", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "patient_profile_id"
    t.date     "date"
    t.text     "location",           limit: 65535
    t.text     "o2level",            limit: 65535
    t.text     "heartrate",          limit: 65535
    t.text     "headposition",       limit: 65535
    t.text     "headrotation",       limit: 65535
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "qns", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "q_name",                   null: false
    t.string   "q_type"
    t.integer  "q_count",                  null: false
    t.text     "q1",         limit: 65535
    t.text     "q2",         limit: 65535
    t.text     "q3",         limit: 65535
    t.text     "q4",         limit: 65535
    t.text     "q5",         limit: 65535
    t.text     "q6",         limit: 65535
    t.text     "q7",         limit: 65535
    t.text     "q8",         limit: 65535
    t.text     "q9",         limit: 65535
    t.text     "q10",        limit: 65535, null: false
    t.text     "q11",        limit: 65535, null: false
    t.text     "q12",        limit: 65535, null: false
    t.text     "q13",        limit: 65535, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "request_qns", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "q_type"
    t.integer  "patient_profile_id",               null: false
    t.integer  "status"
    t.integer  "q1"
    t.integer  "q2"
    t.integer  "q3"
    t.integer  "q4"
    t.integer  "q5"
    t.integer  "q6"
    t.integer  "q7"
    t.integer  "q8"
    t.integer  "q9"
    t.integer  "q10"
    t.integer  "q11"
    t.integer  "q12"
    t.integer  "q13"
    t.text     "detail",             limit: 65535
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "staff_profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "authcons_id"
    t.string   "image"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "sex"
    t.string   "birthdate"
    t.string   "email"
    t.string   "phone_number"
    t.string   "nhs_number",                 null: false
    t.string   "address"
    t.string   "occupation"
    t.text     "detail",       limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

end
