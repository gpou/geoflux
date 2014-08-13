class CreateEstimateDetailsRoro < ActiveRecord::Migration
  def change
    create_table :estimate_details_roro do |t|
      t.boolean :items_different_sizes
      t.timestamps
    end
  end
end