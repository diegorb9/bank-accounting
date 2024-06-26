# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_05_013404) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_movements", force: :cascade do |t|
    t.decimal "amount", precision: 8, scale: 2, null: false
    t.bigint "account_id", null: false
    t.integer "operator", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_account_movements_on_account_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_accounts_on_customer_id", unique: true
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.string "document", null: false
    t.string "access_token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "account_movements", "accounts"
  add_foreign_key "accounts", "customers"
end
