class CreateEstimateNote < ActiveRecord::Migration
  def change
    create_table :estimate_notes do |t|
      t.belongs_to :estimate
      t.text :note
      t.timestamps
    end
    add_index :estimate_notes, :estimate_id
  end
end
