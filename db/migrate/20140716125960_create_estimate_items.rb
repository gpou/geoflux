class CreateEstimateItems < ActiveRecord::Migration
  def change
    create_table :estimate_items do |t|
      t.references :estimateable, :polymorphic => true
      t.decimal :length
      t.decimal :width
      t.decimal :height
      t.decimal :weight
      t.text :description
      t.timestamps
    end
  end
end