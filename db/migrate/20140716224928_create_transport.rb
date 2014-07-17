class CreateTransport < ActiveRecord::Migration
  def change
    create_table :transports do |t|
      t.belongs_to :estimate
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
      t.datetime :started_at
      t.datetime :arrived_at
      t.timestamps
    end
    add_index :transports, :type
    add_index :transports, :state
    add_index :transports, :estimate_id
    add_index :transports, :customer_id
    add_index :transports, :started_at
    add_index :transports, :arrived_at
  end
end
