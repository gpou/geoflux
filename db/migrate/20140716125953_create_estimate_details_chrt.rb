class CreateEstimateDetailsChrt < ActiveRecord::Migration
  def change
    create_table :estimate_details_chrt do |t|
      t.string :origin_address
      t.string :origin_city
      t.string :origin_zip
      t.belongs_to :origin_country
      t.string :destination_address
      t.string :destination_city
      t.string :destination_zip
      t.belongs_to :destination_country
      t.boolean :spot
      t.boolean :regular
      t.integer :shipments_per_month
      t.decimal :weight
      t.text :description
      t.string :stowage_factor
      t.string :loading_laytime
      t.string :unloading_laytime
      t.string :charterer

      t.timestamps
    end
  end
end