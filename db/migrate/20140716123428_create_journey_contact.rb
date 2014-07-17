class CreateJourneyContact < ActiveRecord::Migration
  def change
    create_table :journey_contacts do |t|
      t.belongs_to :origin_port
      t.belongs_to :destination_port
      t.belongs_to :contact
      t.boolean :reefer
      t.boolean :lcl
      t.boolean :fcl
      t.boolean :roro
      t.boolean :flexitank
      t.text :comments
      t.timestamps
    end
    add_index :journey_contacts, :origin_port_id
    add_index :journey_contacts, :destination_port_id
  end
end
