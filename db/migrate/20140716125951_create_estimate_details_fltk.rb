class CreateEstimateDetailsFltk < ActiveRecord::Migration
  def change
    create_table :estimate_details_fltk do |t|
      t.string :origin_address
      t.string :origin_city
      t.string :origin_zip
      t.belongs_to :origin_country
      t.string :destination_address
      t.string :destination_city
      t.string :destination_zip
      t.belongs_to :destination_country
      t.text :description
      t.timestamps
    end
  end
end