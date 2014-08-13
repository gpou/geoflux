class CreateEstimateRequests < ActiveRecord::Migration
  def change
    create_table :estimate_requests do |t|
      t.belongs_to :estimate
      t.belongs_to :contact
      t.text :email_content
      t.string :state
      t.text :comments
      t.datetime :sent_at
      t.datetime :no_response_at
      t.datetime :dismissed_at
      t.datetime :selected_at
      t.datetime :accepted_at
      t.timestamps
    end
    add_index :estimate_requests, :estimate_id
    add_index :estimate_requests, :contact_id
    add_index :estimate_requests, :state
    add_index :estimate_requests, :sent_at
    add_index :estimate_requests, :accepted_at
  end
end
