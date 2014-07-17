class CreateEstimate < ActiveRecord::Migration
  def change
    create_table :estimates do |t|
      t.belongs_to :customer
      t.string :type
      t.string :state
      t.integer :number_of_items
      t.belongs_to :origin_port
      t.belongs_to :destination_port
      t.string :origin_address
      t.string :origin_city
      t.string :origin_zip
      t.belongs_to :origin_country
      t.string :destination_address
      t.string :destination_city
      t.string :destination_zip
      t.belongs_to :destination_country
      t.text :comments
      t.datetime :sent_estimate_requests_at
      t.datetime :received_estimate_requests_at
      t.datetime :sent_to_customer_at
      t.datetime :confirmed_at
      t.datetime :cancelled_at
      t.timestamps
    end
    add_index :estimates, :type
    add_index :estimates, :state
    add_index :estimates, :customer_id
    add_index :estimates, :confirmed_at
  end
end
