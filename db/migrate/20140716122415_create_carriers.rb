class CreateCarriers < ActiveRecord::Migration
  def change
    create_table :carriers do |t|
      t.string :name
      t.string :acronym
      t.string :invoice_name
      t.string :invoice_street
      t.string :invoice_city
      t.string :invoice_zip
      t.integer :invoice_country_id
      t.string :invoice_nif

      t.text :comments
      t.timestamps
    end
  end
end
