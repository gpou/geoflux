class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.belongs_to :carrier
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.text :comments
      t.timestamps
    end
    add_index :contacts, :carrier_id
    add_index :contacts, :email
  end
end
