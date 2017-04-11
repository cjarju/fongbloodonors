class CreateDatabase < ActiveRecord::Migration
  def self.up
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

  def self.down
    # drop all the tables if you really need
    # to support migration back to version 0
  end
end