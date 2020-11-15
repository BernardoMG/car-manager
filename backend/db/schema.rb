# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_15_200938) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cars", force: :cascade do |t|
    t.date "available_from", null: false
    t.integer "year", null: false
    t.decimal "monthly", null: false
    t.bigint "color_id", null: false
    t.bigint "model_id", null: false
    t.bigint "maker_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["available_from"], name: "index_cars_on_available_from"
    t.index ["color_id"], name: "index_cars_on_color_id"
    t.index ["maker_id"], name: "index_cars_on_maker_id"
    t.index ["model_id"], name: "index_cars_on_model_id"
    t.index ["monthly"], name: "index_cars_on_monthly"
    t.index ["year"], name: "index_cars_on_year"
  end

  create_table "colors", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "makers", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_makers_on_name"
  end

  create_table "model_colors", force: :cascade do |t|
    t.bigint "model_id", null: false
    t.bigint "color_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["color_id"], name: "index_model_colors_on_color_id"
    t.index ["model_id"], name: "index_model_colors_on_model_id"
  end

  create_table "models", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "maker_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["maker_id"], name: "index_models_on_maker_id"
  end

  add_foreign_key "model_colors", "colors"
  add_foreign_key "model_colors", "models"
end
