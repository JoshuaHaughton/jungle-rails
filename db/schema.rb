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

ActiveRecord::Schema.define(version: 20220106222845) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.integer "question_id"
    t.boolean "answer",                      null: false
    t.boolean "is_correct",  default: false, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.integer  "item_price_cents"
    t.integer  "total_price_cents"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id", using: :btree
  add_index "line_items", ["product_id"], name: "index_line_items_on_product_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "total_cents"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "stripe_charge_id"
    t.string   "email"
  end

  create_table "previous_attempts", force: :cascade do |t|
    t.integer "quiz_id"
    t.integer "user_id"
    t.integer "score"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "image"
    t.integer  "price_cents"
    t.integer  "quantity"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.integer "quiz_id"
    t.text    "question", null: false
  end

  create_table "quizzes", force: :cascade do |t|
    t.integer "owner_id"
    t.string  "title",       limit: 255,                null: false
    t.text    "description",                            null: false
    t.boolean "public",                  default: true
  end

  create_table "sales", force: :cascade do |t|
    t.string   "name"
    t.integer  "percent_off"
    t.date     "starts_on"
    t.date     "ends_on"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username",        limit: 255, null: false
    t.string "email",           limit: 255, null: false
    t.string "password_digest", limit: 255, null: false
  end

  add_foreign_key "answers", "questions", name: "answers_question_id_fkey", on_delete: :cascade
  add_foreign_key "line_items", "orders"
  add_foreign_key "line_items", "products"
  add_foreign_key "previous_attempts", "quizzes", name: "previous_attempts_quiz_id_fkey", on_delete: :cascade
  add_foreign_key "previous_attempts", "users", name: "previous_attempts_user_id_fkey", on_delete: :cascade
  add_foreign_key "products", "categories"
  add_foreign_key "questions", "quizzes", name: "questions_quiz_id_fkey", on_delete: :cascade
  add_foreign_key "quizzes", "users", column: "owner_id", name: "quizzes_owner_id_fkey", on_delete: :cascade
end
