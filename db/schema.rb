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

ActiveRecord::Schema.define(version: 2022_05_26_083920) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.bigint "customer_id", null: false, comment: "顧客への外部キー"
    t.string "type", null: false, comment: "継承カラム"
    t.string "postal_code", null: false, comment: "郵便番号"
    t.string "prefecture", null: false, comment: "都道府県"
    t.string "city", null: false, comment: "市区町村"
    t.string "address1", null: false, comment: "町域、番地等"
    t.string "address2", null: false, comment: "建物名、部屋番号等"
    t.string "company_name", default: "", null: false, comment: "会社名"
    t.string "division_name", default: "", null: false, comment: "部署名"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city"], name: "index_addresses_on_city"
    t.index ["customer_id"], name: "index_addresses_on_customer_id"
    t.index ["prefecture", "city"], name: "index_addresses_on_prefecture_and_city"
    t.index ["type", "city"], name: "index_addresses_on_type_and_city"
    t.index ["type", "customer_id"], name: "index_addresses_on_type_and_customer_id", unique: true
    t.index ["type", "prefecture", "city"], name: "index_addresses_on_type_and_prefecture_and_city"
  end

  create_table "administrators", force: :cascade do |t|
    t.string "email", null: false, comment: "メールアドレス"
    t.string "hashed_password", comment: "パスワード"
    t.boolean "suspended", default: false, null: false, comment: "無効フラグ"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "lower((email)::text)", name: "index_administrators_on_LOWER_email", unique: true
  end

  create_table "customers", force: :cascade do |t|
    t.string "email", null: false, comment: "メールアドレス"
    t.string "family_name", null: false, comment: "姓"
    t.string "given_name", null: false, comment: "名"
    t.string "family_name_kana", null: false, comment: "姓（セイ）"
    t.string "given_name_kana", null: false, comment: "名（メイ）"
    t.string "gender", comment: "性別"
    t.date "birthday", comment: "誕生日"
    t.string "hashed_password", comment: "パスワード"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "birth_year"
    t.integer "birth_month"
    t.integer "birth_mday"
    t.index "lower((email)::text)", name: "index_customers_on_LOWER_email", unique: true
    t.index ["birth_mday", "family_name_kana", "given_name_kana"], name: "index_customers_on_birth_mday_and_furigana"
    t.index ["birth_mday", "given_name_kana"], name: "index_customers_on_birth_mday_and_given_name_kana"
    t.index ["birth_month", "birth_mday"], name: "index_customers_on_birth_month_and_birth_mday"
    t.index ["birth_month", "family_name_kana", "given_name_kana"], name: "index_customers_on_birth_month_and_furigana"
    t.index ["birth_month", "given_name_kana"], name: "index_customers_on_birth_month_and_given_name_kana"
    t.index ["birth_year", "birth_month", "birth_mday"], name: "index_customers_on_birth_year_and_birth_month_and_birth_mday"
    t.index ["birth_year", "family_name_kana", "given_name_kana"], name: "index_customers_on_birth_year_and_furigana"
    t.index ["birth_year", "given_name_kana"], name: "index_customers_on_birth_year_and_given_name_kana"
    t.index ["family_name_kana", "given_name_kana"], name: "index_customers_on_family_name_kana_and_given_name_kana"
    t.index ["given_name_kana"], name: "index_customers_on_given_name_kana"
  end

  create_table "phones", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "address_id"
    t.string "number", null: false, comment: "電話番号"
    t.string "number_for_index", null: false, comment: "検索用電話番号"
    t.boolean "primary", default: false, null: false, comment: "優先フラグ"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["address_id"], name: "index_phones_on_address_id"
    t.index ["customer_id"], name: "index_phones_on_customer_id"
    t.index ["number_for_index"], name: "index_phones_on_number_for_index"
  end

  create_table "staff_events", force: :cascade do |t|
    t.bigint "staff_member_id", null: false, comment: "職員レコードへの外部キー"
    t.string "type", null: false, comment: "イベントタイプ"
    t.datetime "created_at", null: false, comment: "発生時刻"
    t.index ["created_at"], name: "index_staff_events_on_created_at"
    t.index ["staff_member_id", "created_at"], name: "index_staff_events_on_staff_member_id_and_created_at"
  end

  create_table "staff_members", force: :cascade do |t|
    t.string "email", null: false, comment: "メールアドレス"
    t.string "family_name", null: false, comment: "姓"
    t.string "given_name", null: false, comment: "名"
    t.string "family_name_kana", null: false, comment: "姓（カナ）"
    t.string "given_name_kana", null: false, comment: "名（カナ）"
    t.string "hashed_password", comment: "パスワード"
    t.date "start_date", null: false, comment: "開始日"
    t.date "end_date", comment: "終了日"
    t.boolean "suspended", default: false, null: false, comment: "無効フラグ"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "lower((email)::text)", name: "index_staff_members_on_LOWER_email", unique: true
    t.index ["family_name_kana", "given_name_kana"], name: "index_staff_members_on_family_name_kana_and_given_name_kana"
  end

  add_foreign_key "addresses", "customers"
  add_foreign_key "phones", "addresses"
  add_foreign_key "phones", "customers"
  add_foreign_key "staff_events", "staff_members"
end
