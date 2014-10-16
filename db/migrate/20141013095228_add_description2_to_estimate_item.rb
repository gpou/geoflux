class AddDescription2ToEstimateItem < ActiveRecord::Migration
  def change
    add_column :estimate_items, :description2, :text
  end
end
