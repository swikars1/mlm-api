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

ActiveRecord::Schema.define(version: 2020_09_29_135835) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customer_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "customer_anc_desc_idx", unique: true
    t.index ["descendant_id"], name: "customer_desc_idx"
  end

  create_table "customer_products", force: :cascade do |t|
    t.bigint "customer_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_customer_products_on_customer_id"
    t.index ["product_id"], name: "index_customer_products_on_product_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.string "email"
    t.string "phone_no", null: false
    t.float "expenditure"
    t.string "gender"
    t.string "address"
    t.date "birthday"
    t.boolean "is_agent", default: false
    t.date "last_active_at"
    t.bigint "retailer_id"
    t.bigint "parent_id"
    t.bigint "user_id"
    t.string "refer_code"
    t.date "membership_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_customers_on_name"
  end

  create_table "jwt_denylists", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylists_on_jti"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "retailer_id"
    t.bigint "product_id"
    t.string "name", null: false
    t.float "expenditure", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.float "price"
    t.bigint "qty"
    t.bigint "retailer_id"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profits", force: :cascade do |t|
    t.bigint "payment_id"
    t.bigint "customer_id"
    t.float "total_profit"
    t.float "self_profit"
    t.float "company_profit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "retailer_id"
  end

  create_table "retailer_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "retailers", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone_no", null: false
    t.string "address"
    t.string "pan_number"
    t.bigint "retailer_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_retailers_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "customer_products", "customers"
  add_foreign_key "customer_products", "products"
end
