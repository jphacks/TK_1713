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

ActiveRecord::Schema.define(version: 20171029041549) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cooking_processes", force: :cascade do |t|
    t.integer "step"
    t.string "description"
    t.string "kind"
    t.boolean "use_stove"
    t.boolean "leavable"
    t.float "duration"
    t.float "movie_start"
    t.float "movie_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "recipe_id"
    t.index ["recipe_id"], name: "index_cooking_processes_on_recipe_id"
  end

  create_table "cookwares", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "creates", force: :cascade do |t|
    t.string "recipe_tag"
    t.bigint "recipe_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_creates_on_recipe_id"
    t.index ["tag_id"], name: "index_creates_on_tag_id"
  end

  create_table "foods", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string "url"
    t.bigint "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_movies_on_recipe_id"
  end

  create_table "recipe_foods", force: :cascade do |t|
    t.float "amount"
    t.integer "servings"
    t.bigint "recipe_id"
    t.bigint "food_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "unit"
    t.string "serving_name"
    t.string "amount_name"
    t.index ["food_id"], name: "index_recipe_foods_on_food_id"
    t.index ["recipe_id"], name: "index_recipe_foods_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.string "movie_url"
    t.string "original_id"
    t.string "thumbnail_url"
    t.index ["category_id"], name: "index_recipes_on_category_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cooking_processes", "recipes"
  add_foreign_key "creates", "recipes"
  add_foreign_key "creates", "tags"
  add_foreign_key "movies", "recipes"
  add_foreign_key "recipe_foods", "foods"
  add_foreign_key "recipe_foods", "recipes"
  add_foreign_key "recipes", "categories"
end
