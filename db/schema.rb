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

ActiveRecord::Schema[7.2].define(version: 2024_11_13_000852) do
  create_table "clientes", force: :cascade do |t|
    t.string "nome"
    t.string "telefone"
    t.string "email"
    t.string "endereco"
    t.text "observacoes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "data_nascimento"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "salary"
    t.string "position"
    t.string "password_digest"
    t.date "admission_date"
    t.date "dismissal_date"
    t.date "birth_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.string "unityMeasure"
    t.decimal "quantityStock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantityStockMin"
    t.integer "quantityStockMax"
  end

  create_table "ingredients_products", id: false, force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "ingredient_id", null: false
    t.index ["ingredient_id", "product_id"], name: "index_ingredients_products_on_ingredient_id_and_product_id"
    t.index ["product_id", "ingredient_id"], name: "index_ingredients_products_on_product_id_and_ingredient_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "customer_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders_products", id: false, force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "product_id", null: false
    t.index ["order_id", "product_id"], name: "index_orders_products_on_order_id_and_product_id"
    t.index ["product_id", "order_id"], name: "index_orders_products_on_product_id_and_order_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "cnpj"
    t.string "phone"
    t.string "email"
    t.string "segment"
    t.string "products"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
