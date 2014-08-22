class CreateEstimateItems < ActiveRecord::Migration
  def change
    create_table :estimate_items do |t|
      t.references :estimate
      t.integer :number_of_items
      t.decimal :length, :precision => 10, :scale => 4
      t.decimal :width, :precision => 10, :scale => 4
      t.decimal :height, :precision => 10, :scale => 4
      t.decimal :weight, :precision => 10, :scale => 4
      t.text :description
      t.timestamps
    end
    add_index :estimate_items, :estimate_id
    add_index :estimate_items, :number_of_items
  end
end