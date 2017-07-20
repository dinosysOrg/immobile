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

ActiveRecord::Schema.define(version: 20170413035113) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "pgcrypto"
  enable_extension "postgis"

  create_table "contract_services", id: :bigserial, force: :cascade do |t|
    t.integer  "contract_id", limit: 8,                   null: false
    t.integer  "service_id",  limit: 8,                   null: false
    t.datetime "created_at",            default: "now()"
    t.datetime "updated_at",            default: "now()"
  end

  create_table "contracts", id: :bigserial, force: :cascade do |t|
    t.integer  "house_id",   limit: 8,                   null: false
    t.integer  "user_id",    limit: 8,                   null: false
    t.datetime "created_at",           default: "now()"
    t.datetime "updated_at",           default: "now()"
  end

  create_table "conveniences", id: :bigserial, force: :cascade do |t|
    t.string   "identifier",  limit: 50,                    null: false
    t.string   "name",        limit: 100,                   null: false
    t.string   "description", limit: 500
    t.string   "photo",       limit: 500
    t.boolean  "in_house",                default: false
    t.datetime "created_at",              default: "now()"
    t.datetime "updated_at",              default: "now()"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "estates", id: :bigserial, force: :cascade do |t|
    t.string "identifier",  limit: 50,  null: false
    t.string "name",        limit: 100, null: false
    t.string "type",        limit: 100
    t.string "description", limit: 500
  end

  create_table "furnitures", id: :bigserial, force: :cascade do |t|
    t.string   "identifier", limit: 50,                    null: false
    t.string   "name",       limit: 200,                   null: false
    t.datetime "created_at",             default: "now()"
    t.datetime "updated_at",             default: "now()"
  end

  create_table "house_conveniences", id: :bigserial, force: :cascade do |t|
    t.integer  "house_id",       limit: 8,                   null: false
    t.integer  "convenience_id", limit: 8,                   null: false
    t.datetime "created_at",               default: "now()"
    t.datetime "updated_at",               default: "now()"
  end

  create_table "house_furnitures", id: :bigserial, force: :cascade do |t|
    t.integer  "house_id",     limit: 8,                   null: false
    t.integer  "furniture_id", limit: 8,                   null: false
    t.datetime "created_at",             default: "now()"
    t.datetime "updated_at",             default: "now()"
  end

  create_table "house_tags", id: :bigserial, force: :cascade do |t|
    t.integer  "house_id",   limit: 8,                   null: false
    t.integer  "tag_id",     limit: 8,                   null: false
    t.datetime "created_at",           default: "now()"
    t.datetime "updated_at",           default: "now()"
  end

  create_table "houses", id: :bigserial, force: :cascade do |t|
    t.string   "name",            limit: 500,                                             null: false
    t.string   "link",            limit: 500,                                             null: false
    t.string   "address",         limit: 200
    t.integer  "number_bedroom"
    t.integer  "number_bathroom"
    t.integer  "size"
    t.integer  "price"
    t.string   "currency",        limit: 50
    t.boolean  "for_rent",                                              default: false
    t.string   "matterport_url",  limit: 200
    t.text     "description"
    t.string   "host_type",       limit: 50
    t.string   "status",          limit: 50
    t.boolean  "is_available",                                          default: true
    t.integer  "project_id",      limit: 8
    t.integer  "user_id",         limit: 8
    t.integer  "estate_id",       limit: 8
    t.boolean  "is_show",                                               default: true
    t.boolean  "is_home",                                               default: false
    t.decimal  "latitude",                    precision: 16, scale: 10
    t.decimal  "longitude",                   precision: 16, scale: 10
    t.datetime "disable_at",                                            default: "now()"
    t.datetime "created_at",                                            default: "now()"
    t.datetime "updated_at",                                            default: "now()"
  end

  create_table "photos", id: :bigserial, force: :cascade do |t|
    t.integer  "user_id",     limit: 8
    t.integer  "house_id",    limit: 8
    t.integer  "project_id",  limit: 8
    t.text     "description"
    t.string   "photo_url",   limit: 200
    t.datetime "created_at",              default: "now()"
    t.datetime "updated_at",              default: "now()"
  end

  create_table "project_conveniences", id: :bigserial, force: :cascade do |t|
    t.integer  "project_id",     limit: 8,                   null: false
    t.integer  "convenience_id", limit: 8,                   null: false
    t.datetime "created_at",               default: "now()"
    t.datetime "updated_at",               default: "now()"
  end

  create_table "projects", id: :bigserial, force: :cascade do |t|
    t.string   "name",                     limit: 200,                                             null: false
    t.string   "link",                     limit: 500
    t.string   "photo",                    limit: 500
    t.text     "description"
    t.string   "address",                  limit: 200
    t.integer  "size"
    t.integer  "size_construction"
    t.datetime "time_bulding"
    t.datetime "time_completion"
    t.integer  "number_block"
    t.integer  "number_house"
    t.integer  "number_shophouse"
    t.integer  "number_floor"
    t.string   "investor",                 limit: 200
    t.string   "inc_management",           limit: 200
    t.string   "inc_design",               limit: 200
    t.string   "green_space",              limit: 200
    t.string   "destinition_construction", limit: 200
    t.integer  "fee_management"
    t.integer  "fee_park_car"
    t.integer  "fee_park_moto"
    t.string   "currency",                 limit: 200
    t.string   "progress_construction",    limit: 500
    t.string   "sale_policy",              limit: 500
    t.boolean  "is_show",                                                        default: true
    t.boolean  "is_available",                                                   default: true
    t.boolean  "is_home",                                                        default: false
    t.decimal  "latitude",                             precision: 16, scale: 10
    t.decimal  "longitude",                            precision: 16, scale: 10
    t.datetime "created_at",                                                     default: "now()"
    t.datetime "updated_at",                                                     default: "now()"
  end

  create_table "role_users", id: :bigserial, force: :cascade do |t|
    t.integer  "user_id",    limit: 8,                   null: false
    t.integer  "role_id",    limit: 8,                   null: false
    t.datetime "created_at",           default: "now()"
    t.datetime "updated_at",           default: "now()"
  end

  create_table "roles", id: :bigserial, force: :cascade do |t|
    t.string "identifier", limit: 50, null: false
    t.string "name",       limit: 50
  end

  create_table "services", id: :bigserial, force: :cascade do |t|
    t.string   "identifier",  limit: 50,                    null: false
    t.string   "name",        limit: 200,                   null: false
    t.text     "description"
    t.integer  "price"
    t.string   "currency",    limit: 50
    t.datetime "created_at",              default: "now()"
    t.datetime "updated_at",              default: "now()"
  end

# Could not dump table "spatial_areas" because of following StandardError
#   Unknown type 'geography' for column 'area'

  create_table "spatial_ref_sys", primary_key: "srid", force: :cascade do |t|
    t.string  "auth_name", limit: 256
    t.integer "auth_srid"
    t.string  "srtext",    limit: 2048
    t.string  "proj4text", limit: 2048
  end

  create_table "tags", id: :bigserial, force: :cascade do |t|
    t.string  "name",  limit: 100
    t.integer "count", limit: 8,   null: false
  end

  create_table "users", id: :bigserial, force: :cascade do |t|
    t.string   "email",                  limit: 100, default: ""
    t.string   "phone",                  limit: 100, default: ""
    t.string   "skype",                  limit: 100, default: ""
    t.string   "address",                limit: 200
    t.string   "encrypted_password",     limit: 500, default: ""
    t.string   "reset_password_token",   limit: 500
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 8,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token",     limit: 500
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 500
    t.integer  "failed_attempts",                    default: 0
    t.string   "unlock_token",           limit: 500
    t.datetime "locked_at"
    t.string   "firstname",              limit: 100
    t.string   "lastname",               limit: 100
    t.string   "name",                   limit: 100
    t.string   "avatar",                 limit: 500
    t.string   "provider",               limit: 100
    t.string   "uid",                    limit: 500
    t.boolean  "is_home",                            default: false
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "is_available",                       default: true
    t.integer  "budget",                 limit: 8,   default: 0
  end

  add_foreign_key "contract_services", "contracts", name: "contract_services_contract_id_fkey"
  add_foreign_key "contract_services", "services", name: "contract_services_service_id_fkey"
  add_foreign_key "contracts", "houses", name: "contracts_house_id_fkey"
  add_foreign_key "contracts", "users", name: "contracts_user_id_fkey"
  add_foreign_key "house_conveniences", "conveniences", name: "house_conveniences_convenience_id_fkey"
  add_foreign_key "house_conveniences", "houses", name: "house_conveniences_house_id_fkey"
  add_foreign_key "house_furnitures", "furnitures", name: "house_furnitures_furniture_id_fkey"
  add_foreign_key "house_furnitures", "houses", name: "house_furnitures_house_id_fkey"
  add_foreign_key "house_tags", "houses", name: "house_tags_house_id_fkey"
  add_foreign_key "house_tags", "tags", name: "house_tags_tag_id_fkey"
  add_foreign_key "houses", "estates", name: "houses_estate_id_fkey"
  add_foreign_key "houses", "projects", name: "houses_project_id_fkey"
  add_foreign_key "houses", "users", name: "houses_user_id_fkey"
  add_foreign_key "photos", "houses", name: "photos_house_id_fkey"
  add_foreign_key "photos", "users", name: "photos_user_id_fkey"
  add_foreign_key "project_conveniences", "conveniences", name: "project_conveniences_convenience_id_fkey"
  add_foreign_key "project_conveniences", "projects", name: "project_conveniences_project_id_fkey"
  add_foreign_key "role_users", "roles", name: "role_users_role_id_fkey"
  add_foreign_key "role_users", "users", name: "role_users_user_id_fkey"
end
