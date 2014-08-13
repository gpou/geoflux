class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :company
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
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
