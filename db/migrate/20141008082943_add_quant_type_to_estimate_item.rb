class AddQuantTypeToEstimateItem < ActiveRecord::Migration
  def change
    add_column :estimate_items, :quant_type, :string, :default => "quant", after: :estimate_id
  end
end
