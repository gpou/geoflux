class CreateCarriers < ActiveRecord::Migration
  def change
    create_table :carriers do |t|
      t.string :name
      t.text :comments
      t.timestamps
    end
  end
end
