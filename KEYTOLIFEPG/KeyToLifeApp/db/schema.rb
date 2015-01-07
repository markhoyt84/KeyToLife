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

ActiveRecord::Schema.define(version: 20141231164405) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "cart_items", force: true do |t|
    t.string   "name"
    t.string   "size"
    t.string   "sku"
    t.decimal  "price",            precision: 8, scale: 2
    t.integer  "category_id"
    t.integer  "description_id"
    t.integer  "shopping_cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "descriptions", force: true do |t|
    t.string   "range"
    t.string   "headline"
    t.text     "description"
    t.text     "directions"
    t.string   "derived"
    t.string   "ingredient"
    t.string   "love"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "shopping_cart_id"
    t.integer  "user_id",                                        default: 0
    t.decimal  "total",                  precision: 8, scale: 2
    t.decimal  "shipping_cost",          precision: 8, scale: 2, default: 0.0
    t.decimal  "tax",                    precision: 8, scale: 2, default: 0.0
    t.decimal  "grand_total",            precision: 8, scale: 2
    t.string   "status",                                         default: "Processing"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company"
    t.string   "billing_address"
    t.string   "billing_address_city"
    t.string   "billing_address_state"
    t.string   "billing_address_zip"
    t.string   "shipping_address"
    t.string   "shipping_address_city"
    t.string   "shipping_address_state"
    t.string   "shipping_address_zip"
    t.string   "telephone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.string   "url"
    t.integer  "photoable_id"
    t.string   "photoable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.string   "size"
    t.string   "sku"
    t.decimal  "Dist",           precision: 8, scale: 2
    t.decimal  "WS",             precision: 8, scale: 2
    t.decimal  "MSRP",           precision: 8, scale: 2
    t.integer  "category_id"
    t.integer  "description_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shopping_carts", force: true do |t|
    t.integer  "item_count",                          default: 0
    t.string   "customer_id"
    t.decimal  "total",       precision: 8, scale: 2
    t.float    "taxes"
    t.float    "shipping",                            default: 0.0
    t.boolean  "purchased",                           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscribers", force: true do |t|
    t.string   "email"
    t.string   "name",       default: "Subscriber"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_addresses", force: true do |t|
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company"
    t.string   "billing_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "telephone"
    t.string   "tier"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
