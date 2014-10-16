class AddEmailContentToEstimate < ActiveRecord::Migration
  def change
    add_column :estimates, :email_content, :text
  end
end
