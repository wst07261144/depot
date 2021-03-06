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

ActiveRecord::Schema.define(version: 20140601041344) do

  create_table "customer_addresses", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "phone"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "customer_address_id"
    t.string   "color"
    t.string   "num"
    t.string   "size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price"
    t.decimal  "total_price"
    t.string   "name"
    t.string   "img"
    t.boolean  "admin_delete"
    t.boolean  "user_delete"
    t.string   "order_status"
    t.string   "confirm_status"
  end

  create_table "product_colors", force: true do |t|
    t.integer  "product_id"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_images", force: true do |t|
    t.integer  "product_id"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_sizes", force: true do |t|
    t.integer  "product_id"
    t.string   "size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "title"
    t.string   "mian_liao"
    t.string   "logo"
    t.string   "pic_source"
    t.string   "season"
    t.string   "style"
    t.string   "hou_bao"
    t.string   "huo_hao"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price"
    t.string   "sort"
    t.integer  "user_id"
  end

  create_table "shopping_carts", force: true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.string   "color"
    t.string   "size"
    t.integer  "num"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "img"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

end
