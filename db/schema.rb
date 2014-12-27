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

ActiveRecord::Schema.define(version: 20141227135607) do

  create_table "cargos", force: true do |t|
    t.string  "type"
    t.integer "estimate_id"
  end

  add_index "cargos", ["estimate_id"], name: "index_cargos_on_estimate_id", using: :btree

  create_table "carriers", force: true do |t|
    t.string   "name"
    t.string   "acronym"
    t.string   "invoice_name"
    t.string   "invoice_street"
    t.string   "invoice_city"
    t.string   "invoice_zip"
    t.integer  "invoice_country_id"
    t.string   "invoice_nif"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.integer  "carrier_id"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["carrier_id"], name: "index_contacts_on_carrier_id", using: :btree
  add_index "contacts", ["email"], name: "index_contacts_on_email", using: :btree

  create_table "countries", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "countries", ["code"], name: "index_countries_on_code", unique: true, using: :btree

  create_table "customers", force: true do |t|
    t.string   "company"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "invoice_name"
    t.string   "invoice_street"
    t.string   "invoice_city"
    t.string   "invoice_zip"
    t.integer  "invoice_country_id"
    t.string   "invoice_nif"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "estimate_items", force: true do |t|
    t.integer  "estimate_id"
    t.string   "quant_type",                               default: "quant"
    t.integer  "number_of_items"
    t.string   "size_type",                                default: "cubic"
    t.decimal  "length",          precision: 10, scale: 4
    t.decimal  "width",           precision: 10, scale: 4
    t.decimal  "height",          precision: 10, scale: 4
    t.decimal  "diameter",        precision: 10, scale: 4
    t.decimal  "weight",          precision: 10, scale: 4
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.text     "description2"
  end

  add_index "estimate_items", ["estimate_id"], name: "index_estimate_items_on_estimate_id", using: :btree
  add_index "estimate_items", ["number_of_items"], name: "index_estimate_items_on_number_of_items", using: :btree
  add_index "estimate_items", ["type"], name: "index_estimate_items_on_type", using: :btree

  create_table "estimate_requests", force: true do |t|
    t.integer  "estimate_id"
    t.integer  "contact_id"
    t.text     "email_content"
    t.string   "state"
    t.text     "comments"
    t.datetime "sent_at"
    t.datetime "no_response_at"
    t.datetime "dismissed_at"
    t.datetime "selected_at"
    t.datetime "accepted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email_subject"
    t.text     "email_additional_content"
  end

  add_index "estimate_requests", ["accepted_at"], name: "index_estimate_requests_on_accepted_at", using: :btree
  add_index "estimate_requests", ["contact_id"], name: "index_estimate_requests_on_contact_id", using: :btree
  add_index "estimate_requests", ["estimate_id"], name: "index_estimate_requests_on_estimate_id", using: :btree
  add_index "estimate_requests", ["sent_at"], name: "index_estimate_requests_on_sent_at", using: :btree
  add_index "estimate_requests", ["state"], name: "index_estimate_requests_on_state", using: :btree

  create_table "estimates", force: true do |t|
    t.string   "type"
    t.integer  "customer_id"
    t.string   "state"
    t.integer  "number_of_items"
    t.integer  "origin_port_id"
    t.integer  "destination_port_id"
    t.string   "origin_address"
    t.string   "origin_city"
    t.string   "origin_zip"
    t.string   "origin_province"
    t.integer  "origin_country_id"
    t.string   "destination_address"
    t.string   "destination_city"
    t.string   "destination_zip"
    t.string   "destination_province"
    t.integer  "destination_country_id"
    t.boolean  "imo"
    t.string   "imo_class"
    t.string   "imo_un"
    t.string   "shipment_type"
    t.integer  "shipments_per_month"
    t.boolean  "equipment_20_dv"
    t.boolean  "equipment_20_ot"
    t.boolean  "equipment_20_rf"
    t.boolean  "equipment_20_fr"
    t.boolean  "equipment_40_dv"
    t.boolean  "equipment_40_hc"
    t.boolean  "equipment_40_ot"
    t.boolean  "equipment_40_rf"
    t.boolean  "equipment_40_fr"
    t.string   "temperature"
    t.boolean  "oog"
    t.string   "stowage_factor"
    t.string   "loading_laytime"
    t.string   "unloading_laytime"
    t.text     "comments"
    t.datetime "sent_estimate_requests_at"
    t.datetime "received_estimate_requests_at"
    t.datetime "sent_to_customer_at"
    t.datetime "confirmed_at"
    t.datetime "cancelled_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "email_content"
    t.string   "email_subject"
    t.text     "email_additional_content"
  end

  add_index "estimates", ["confirmed_at"], name: "index_estimates_on_confirmed_at", using: :btree
  add_index "estimates", ["customer_id"], name: "index_estimates_on_customer_id", using: :btree
  add_index "estimates", ["destination_port_id"], name: "index_estimates_on_destination_port_id", using: :btree
  add_index "estimates", ["origin_port_id"], name: "index_estimates_on_origin_port_id", using: :btree
  add_index "estimates", ["state"], name: "index_estimates_on_state", using: :btree
  add_index "estimates", ["type"], name: "index_estimates_on_type", using: :btree

  create_table "journey_contacts", force: true do |t|
    t.integer  "origin_port_id"
    t.integer  "destination_port_id"
    t.integer  "contact_id"
    t.boolean  "reefer"
    t.boolean  "lcl"
    t.boolean  "fcl"
    t.boolean  "roro"
    t.boolean  "fltk"
    t.boolean  "cvnl"
    t.boolean  "chrt"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "journey_contacts", ["destination_port_id"], name: "index_journey_contacts_on_destination_port_id", using: :btree
  add_index "journey_contacts", ["origin_port_id"], name: "index_journey_contacts_on_origin_port_id", using: :btree

  create_table "order_items", force: true do |t|
    t.integer  "order_id"
    t.integer  "estimate_item_id"
    t.string   "quant_type"
    t.integer  "number_of_items"
    t.decimal  "weight",           precision: 10, scale: 4
    t.string   "size_type"
    t.decimal  "length",           precision: 10, scale: 4
    t.decimal  "width",            precision: 10, scale: 4
    t.decimal  "height",           precision: 10, scale: 4
    t.decimal  "diameter",         precision: 10, scale: 4
    t.text     "description"
    t.text     "description2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_items", ["number_of_items"], name: "index_order_items_on_number_of_items", using: :btree
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree

  create_table "orders", force: true do |t|
    t.string   "order_type"
    t.integer  "estimate_id"
    t.integer  "customer_id"
    t.integer  "contact_id"
    t.integer  "carrier_id"
    t.string   "reference"
    t.date     "date"
    t.decimal  "price",                    precision: 10, scale: 2
    t.string   "state"
    t.integer  "origin_port_id"
    t.integer  "destination_port_id"
    t.string   "origin_address"
    t.string   "origin_city"
    t.string   "origin_province"
    t.string   "origin_zip"
    t.integer  "origin_country_id"
    t.string   "destination_address"
    t.string   "destination_city"
    t.string   "destination_province"
    t.string   "destination_zip"
    t.integer  "destination_country_id"
    t.boolean  "imo"
    t.string   "imo_class"
    t.string   "imo_un"
    t.string   "shipment_type"
    t.integer  "shipments_per_month"
    t.boolean  "equipment_20_dv"
    t.boolean  "equipment_20_ot"
    t.boolean  "equipment_20_rf"
    t.boolean  "equipment_20_fr"
    t.boolean  "equipment_40_dv"
    t.boolean  "equipment_40_hc"
    t.boolean  "equipment_40_rf"
    t.boolean  "equipment_40_fr"
    t.string   "temperature"
    t.boolean  "oog"
    t.string   "stowage_factor"
    t.string   "loading_laytime"
    t.string   "unloading_laytime"
    t.string   "email_subject"
    t.text     "email_content"
    t.text     "email_additional_content"
    t.text     "comments"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "paid_at"
    t.datetime "cancelled_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["carrier_id"], name: "index_orders_on_carrier_id", using: :btree
  add_index "orders", ["contact_id"], name: "index_orders_on_contact_id", using: :btree
  add_index "orders", ["customer_id"], name: "index_orders_on_customer_id", using: :btree
  add_index "orders", ["date"], name: "index_orders_on_date", using: :btree
  add_index "orders", ["destination_port_id"], name: "index_orders_on_destination_port_id", using: :btree
  add_index "orders", ["order_type"], name: "index_orders_on_order_type", using: :btree
  add_index "orders", ["origin_port_id"], name: "index_orders_on_origin_port_id", using: :btree
  add_index "orders", ["state"], name: "index_orders_on_state", using: :btree

  create_table "ports", force: true do |t|
    t.integer  "country_id"
    t.string   "code"
    t.string   "name"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ports", ["code"], name: "index_ports_on_code", unique: true, using: :btree
  add_index "ports", ["country_id"], name: "index_ports_on_country_id", using: :btree

end
