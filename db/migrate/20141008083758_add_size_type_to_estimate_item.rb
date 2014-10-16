class AddSizeTypeToEstimateItem < ActiveRecord::Migration
  def change
    add_column :estimate_items, :size_type, :string, :default => "cubic", after: :number_of_items
    add_column :estimate_items, :diameter, :decimal, :precision => 10, :scale => 4, after: :height
  end
end
