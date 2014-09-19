class AddEstimatesEquipmentTypes < ActiveRecord::Migration
  def change
    add_column :estimates, :equipment_20_dv, :boolean, after: :equipment
    add_column :estimates, :equipment_20_ot, :boolean, after: :equipment_20_dv
    add_column :estimates, :equipment_20_rf, :boolean, after: :equipment_20_ot
    add_column :estimates, :equipment_20_fr, :boolean, after: :equipment_20_rf
    add_column :estimates, :equipment_40_dv, :boolean, after: :equipment_20_fr
    add_column :estimates, :equipment_40_hc, :boolean, after: :equipment_40_dv
    add_column :estimates, :equipment_40_ot, :boolean, after: :equipment_40_hc
    add_column :estimates, :equipment_40_rf, :boolean, after: :equipment_40_ot
    add_column :estimates, :equipment_40_fr, :boolean, after: :equipment_40_rf
    Fcl.all.each do |e|
      e["equipment_#{e.equipment}"] = true
      e.save
    end
    remove_column :estimates, :equipment
  end
end
