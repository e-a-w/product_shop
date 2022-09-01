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

ActiveRecord::Schema[7.0].define(version: 2022_09_01_010559) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.integer "department", default: 0, null: false
    t.integer "discount_percent", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feature_windows", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.boolean "featured", default: false, null: false
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_feature_windows_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.string "description", limit: 200
    t.integer "price", default: 0, null: false
    t.integer "quantity", default: 0, null: false
    t.datetime "last_sold_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id", null: false
  end

end
