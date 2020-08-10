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

ActiveRecord::Schema.define(version: 2020_08_10_025839) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_ranks", force: :cascade do |t|
    t.bigint "account_id"
    t.integer "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_ranks_on_account_id"
  end

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
    t.bigint "account_id"
    t.string "postal_code"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_addresses_on_account_id"
  end

  create_table "logs", force: :cascade do |t|
    t.bigint "operation_id"
    t.integer "account_id"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["operation_id"], name: "index_logs_on_operation_id"
  end

  create_table "operations", force: :cascade do |t|
    t.string "name"
    t.integer "sub_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_bills", force: :cascade do |t|
    t.bigint "order_id"
    t.integer "total_price"
    t.integer "discount_price"
    t.integer "shipping_fee"
    t.integer "billing_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_bills_on_order_id"
  end

  create_table "ordered_products", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "product_id"
    t.bigint "quantity"
    t.date "expected_delivery_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_ordered_products_on_order_id"
    t.index ["product_id"], name: "index_ordered_products_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "account_id"
    t.integer "delivery_method"
    t.integer "payment_method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_orders_on_account_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.binary "picture"
    t.integer "ec_stock_id"
    t.integer "store_stock_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "ec_stock_amount"
    t.bigint "store_stock_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_stocks_on_product_id"
  end

end
