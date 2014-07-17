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

ActiveRecord::Schema.define(version: 20140716224928) do

  create_table "carriers", force: true do |t|
    t.string   "name"
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
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "estimate_notes", force: true do |t|
    t.integer  "estimate_id"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estimate_notes", ["estimate_id"], name: "index_estimate_notes_on_estimate_id", using: :btree

  create_table "estimate_requests", force: true do |t|
    t.integer  "estimate_id"
    t.integer  "contact_id"
    t.string   "state"
    t.text     "comments"
    t.datetime "sent_at"
    t.datetime "no_response_at"
    t.datetime "dismissed_at"
    t.datetime "selected_at"
    t.datetime "accepted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estimate_requests", ["accepted_at"], name: "index_estimate_requests_on_accepted_at", using: :btree
  add_index "estimate_requests", ["contact_id"], name: "index_estimate_requests_on_contact_id", using: :btree
  add_index "estimate_requests", ["estimate_id"], name: "index_estimate_requests_on_estimate_id", using: :btree
  add_index "estimate_requests", ["sent_at"], name: "index_estimate_requests_on_sent_at", using: :btree
  add_index "estimate_requests", ["state"], name: "index_estimate_requests_on_state", using: :btree

  create_table "estimates", force: true do |t|
    t.integer  "customer_id"
    t.string   "type"
    t.string   "state"
    t.integer  "number_of_items"
    t.integer  "origin_port_id"
    t.integer  "destination_port_id"
    t.string   "origin_address"
    t.string   "origin_city"
    t.string   "origin_zip"
    t.integer  "origin_country_id"
    t.string   "destination_address"
    t.string   "destination_city"
    t.string   "destination_zip"
    t.integer  "destination_country_id"
    t.text     "comments"
    t.datetime "sent_estimate_requests_at"
    t.datetime "received_estimate_requests_at"
    t.datetime "sent_to_customer_at"
    t.datetime "confirmed_at"
    t.datetime "cancelled_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estimates", ["confirmed_at"], name: "index_estimates_on_confirmed_at", using: :btree
  add_index "estimates", ["customer_id"], name: "index_estimates_on_customer_id", using: :btree
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
    t.boolean  "flexitank"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "journey_contacts", ["destination_port_id"], name: "index_journey_contacts_on_destination_port_id", using: :btree
  add_index "journey_contacts", ["origin_port_id"], name: "index_journey_contacts_on_origin_port_id", using: :btree

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

  create_table "transports", force: true do |t|
    t.integer  "estimate_id"
    t.integer  "customer_id"
    t.string   "type"
    t.string   "state"
    t.integer  "number_of_items"
    t.integer  "origin_port_id"
    t.integer  "destination_port_id"
    t.string   "origin_address"
    t.string   "origin_city"
    t.string   "origin_zip"
    t.integer  "origin_country_id"
    t.string   "destination_address"
    t.string   "destination_city"
    t.string   "destination_zip"
    t.integer  "destination_country_id"
    t.text     "comments"
    t.datetime "started_at"
    t.datetime "arrived_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transports", ["arrived_at"], name: "index_transports_on_arrived_at", using: :btree
  add_index "transports", ["customer_id"], name: "index_transports_on_customer_id", using: :btree
  add_index "transports", ["estimate_id"], name: "index_transports_on_estimate_id", using: :btree
  add_index "transports", ["started_at"], name: "index_transports_on_started_at", using: :btree
  add_index "transports", ["state"], name: "index_transports_on_state", using: :btree
  add_index "transports", ["type"], name: "index_transports_on_type", using: :btree

end
