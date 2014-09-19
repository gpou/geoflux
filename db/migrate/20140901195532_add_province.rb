class AddProvince < ActiveRecord::Migration
  def change
    add_column :estimates, :origin_province, :string, after: :origin_zip
    add_column :estimates, :destination_province, :string, after: :destination_zip
  end
end
