class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :code
      t.string :name
      t.text :comments
      t.timestamps
    end
    add_index :countries, :code, :unique => true
  end
end
