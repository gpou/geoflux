class AddTypeToEstimateItem < ActiveRecord::Migration
  def change
    add_column :estimate_items, :type, :string
    add_index :estimate_items, :type
  end
end
