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

ActiveRecord::Schema.define(version: 2020_07_18_033027) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.integer "account_type"
    t.string "password"
    t.string "email"
    t.string "tel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "addresses", force: :cascade do |t|
    t.integer "account_id"
    t.string "postal_code"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "string"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logs", force: :cascade do |t|
    t.integer "operation_id"
    t.integer "account_id"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "operations", force: :cascade do |t|
    t.string "name"
    t.integer "sub_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ordered_products", force: :cascade do |t|
    t.bigint "order_id"
    t.integer "product_id"
    t.bigint "quantity"
    t.date "expected_delivery_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_ordered_products_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "account_id"
    t.integer "delivery_method"
    t.integer "payment_method"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.binary "picture"
    t.integer "ec_stock_id"
    t.integer "shop_stock_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
