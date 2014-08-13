class CreateEstimateDetailsFcl < ActiveRecord::Migration
  def change
    create_table :estimate_details_fcl do |t|
      t.string :origin_address
      t.string :origin_city
      t.string :origin_zip
      t.belongs_to :origin_country
      t.string :destination_address
      t.string :destination_city
      t.string :destination_zip
      t.belongs_to :destination_country
      t.string :shipment_type
      t.integer :shipments_per_month
      t.string :equipment
      t.text :description
      t.string :temperature
      t.boolean :imo
      t.string :imo_class
      t.string :imo_un
      t.boolean :oog
      t.decimal :length
      t.decimal :width
      t.decimal :height
      t.decimal :weight

      t.timestamps
    end
  end
end