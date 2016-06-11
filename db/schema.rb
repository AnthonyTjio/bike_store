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

ActiveRecord::Schema.define(version: 20160610171637) do

  create_table "bike_models", force: :cascade do |t|
    t.string   "bike_model_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "customer_name"
    t.text     "customer_address"
    t.string   "customer_phone"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "kucings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.integer  "qty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "price"
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id"
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id"

  create_table "orders", force: :cascade do |t|
    t.integer  "customer_id"
    t.date     "order_date"
    t.integer  "status"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.text     "shipping_address"
    t.integer  "shipping_method"
    t.string   "receipt_number"
    t.date     "shipping_date"
    t.date     "payment_date"
    t.boolean  "is_paid"
    t.boolean  "is_delivered"
  end

  add_index "orders", ["customer_id"], name: "index_orders_on_customer_id"

  create_table "products", force: :cascade do |t|
    t.string   "bike_name"
    t.integer  "bike_model_id"
    t.decimal  "price"
    t.string   "bike_size"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "products", ["bike_model_id"], name: "index_products_on_bike_model_id"

  create_table "stock_histories", force: :cascade do |t|
    t.integer  "stock_id"
    t.integer  "alteration"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "stock_histories", ["stock_id"], name: "index_stock_histories_on_stock_id"

  create_table "stocks", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "qty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "stocks", ["product_id"], name: "index_stocks_on_product_id"

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "user_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
