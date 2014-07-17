class CreatePorts < ActiveRecord::Migration
  def change
    create_table :ports do |t|
      t.belongs_to :country
      t.string :code
      t.string :name
      t.text :comments
      t.timestamps
    end
    add_index :ports, :code, :unique => true
    add_index :ports, :country_id
  end
end
