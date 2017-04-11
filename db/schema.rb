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

ActiveRecord::Schema.define(version: 20140416124021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blood_donors", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "age"
    t.string   "phone_num",      limit: 255
    t.string   "address",        limit: 255
    t.integer  "gender_id"
    t.integer  "blood_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date_donated"
    t.boolean  "used",                       default: false
    t.integer  "recipient_id"
    t.index ["blood_group_id"], name: "index_blood_donors_on_blood_group_id", using: :btree
    t.index ["gender_id"], name: "index_blood_donors_on_gender_id", using: :btree
    t.index ["recipient_id"], name: "index_blood_donors_on_recipient_id", using: :btree
  end

  create_table "blood_groups", force: :cascade do |t|
    t.string   "blood_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blood_receivers", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "age"
    t.string   "phone_num",      limit: 255
    t.string   "address",        limit: 255
    t.integer  "gender_id"
    t.integer  "blood_group_id"
    t.date     "date_received"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "blood_donor_id", limit: 255
    t.index ["blood_donor_id"], name: "index_blood_receivers_on_blood_donor_id", using: :btree
    t.index ["blood_group_id"], name: "index_blood_receivers_on_blood_group_id", using: :btree
    t.index ["gender_id"], name: "index_blood_receivers_on_gender_id", using: :btree
  end

  create_table "genders", force: :cascade do |t|
    t.string   "sexval",     limit: 255
    t.string   "sexlabel",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",  limit: 255
    t.integer  "user_role_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
    t.index ["user_role_id"], name: "index_users_on_user_role_id", using: :btree
  end

end
