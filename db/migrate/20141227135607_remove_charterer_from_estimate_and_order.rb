class RemoveChartererFromEstimateAndOrder < ActiveRecord::Migration
  def change
    remove_column :estimates, :charterer
    remove_column :orders, :charterer
  end
end
