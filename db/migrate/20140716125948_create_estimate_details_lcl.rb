class CreateEstimateDetailsLcl < ActiveRecord::Migration
  def change
    create_table :estimate_details_lcl do |t|
      t.string :origin_address
      t.string :origin_city
      t.string :origin_zip
      t.belongs_to :origin_country
      t.string :destination_address
      t.string :destination_city
      t.string :destination_zip
      t.belongs_to :destination_country
      t.boolean :items_different_sizes
      t.boolean :imo
      t.string :imo_class
      t.string :imo_un
      t.timestamps
    end
  end
end