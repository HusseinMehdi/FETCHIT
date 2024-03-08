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

ActiveRecord::Schema[7.0].define(version: 2024_03_06_134205) do
  create_table "__ConfigMigrationHistory", primary_key: ["MigrationId", "ContextKey"], force: :cascade do |t|
    t.string "MigrationId", limit: 150, null: false
    t.string "ContextKey", limit: 300, null: false
  end

  create_table "__MigrationHistory", primary_key: ["MigrationId", "ContextKey"], force: :cascade do |t|
    t.string "MigrationId", limit: 150, null: false
    t.string "ContextKey", limit: 300, null: false
    t.binary "Model", null: false
    t.string "ProductVersion", limit: 32, null: false
  end

  create_table "reports", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "firstName"
    t.string "lastName"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
