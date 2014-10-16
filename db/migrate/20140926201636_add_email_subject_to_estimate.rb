class AddEmailSubjectToEstimate < ActiveRecord::Migration
  def change
    add_column :estimates, :email_subject, :string
    add_column :estimate_requests, :email_subject, :string
  end
end
