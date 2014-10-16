class AddEmailAdditionalContentToEstimate < ActiveRecord::Migration
  def change
    add_column :estimates, :email_additional_content, :text
    add_column :estimate_requests, :email_additional_content, :text
  end
end
