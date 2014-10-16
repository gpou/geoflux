class CreateOrderItem < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.belongs_to :order
      t.belongs_to :estimate_item
      t.string :quant_type
      t.integer :number_of_items
      t.decimal :weight, :precision => 10, :scale => 4
      t.string :size_type
      t.decimal :length, :precision => 10, :scale => 4
      t.decimal :width, :precision => 10, :scale => 4
      t.decimal :height, :precision => 10, :scale => 4
      t.decimal :diameter, :precision => 10, :scale => 4
      t.text :description
      t.text :description2
      t.timestamps
    end
    add_index :order_items, :order_id
    add_index :order_items, :number_of_items
  end
end
