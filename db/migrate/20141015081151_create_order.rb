class CreateOrder < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :order_type
      t.belongs_to :estimate
      t.belongs_to :customer
      t.belongs_to :contact
      t.belongs_to :carrier
      t.string :reference
      t.date :date
      t.decimal :price, :precision => 10, :scale => 2
      t.string :state
      t.belongs_to :origin_port
      t.belongs_to :destination_port
      t.string :origin_address
      t.string :origin_city
      t.string :origin_province
      t.string :origin_zip
      t.belongs_to :origin_country
      t.string :destination_address
      t.string :destination_city
      t.string :destination_province
      t.string :destination_zip
      t.belongs_to :destination_country
      t.boolean :imo
      t.string :imo_class
      t.string :imo_un
      t.string :shipment_type
      t.integer :shipments_per_month
      t.boolean :equipment_20_dv
      t.boolean :equipment_20_ot
      t.boolean :equipment_20_rf
      t.boolean :equipment_20_fr
      t.boolean :equipment_40_dv
      t.boolean :equipment_40_hc
      t.boolean :equipment_40_rf
      t.boolean :equipment_40_fr
      t.string :temperature
      t.boolean :oog
      t.string :stowage_factor
      t.string :loading_laytime
      t.string :unloading_laytime
      t.string :charterer
      t.string :email_subject
      t.text :email_content
      t.text :email_additional_content
      t.text :comments
      t.datetime :started_at
      t.datetime :finished_at
      t.datetime :paid_at
      t.datetime :cancelled_at
      t.timestamps
    end
    add_index :orders, :order_type
    add_index :orders, :state
    add_index :orders, :customer_id
    add_index :orders, :origin_port_id
    add_index :orders, :destination_port_id
    add_index :orders, :carrier_id
    add_index :orders, :contact_id
    add_index :orders, :date
  end
end
