class Fcl < Estimate

  after_initialize :defaults

  def defaults
    self.shipment_type ||= "spot"
    self.imo ||= false
  end

  validates :shipment_type, :presence => true
  validates :shipments_per_month, :presence => true, :if => lambda { |e| e.shipment_type == "regular" }
  validates :shipments_per_month, :numericality => true, :allow_blank => true
  validates :temperature, :presence => true, :if => lambda { |e| e.equipment_20_rf or e.equipment_40_rf }
  validates :imo_class, :presence => true, :if => :imo
  validates :imo_un, :presence => true, :if => :imo
  validates :oog, :presence => true, :if => lambda { |e| e.equipment_20_ot or e.equipment_20_fr or e.equipment_40_ot or e.equipment_40_fr }

  validate :equipment_present

  def equipment_present
    if not equipment_20_dv and not equipment_20_ot and not equipment_20_rf and not equipment_20_fr and not equipment_40_dv and not equipment_40_hc and not equipment_40_ot and not equipment_40_rf and not equipment_40_fr
      errors.add(:equipment, "#{I18n.t("activerecord.attributes.estimate.equipment")} #{I18n.t("errors.messages.blank")}")
    end
  end

  def equipment
    [
      equipment_20_dv ? I18n.t("activerecord.attributes.estimate.equipment_20_dv") : "",
      equipment_20_ot ? I18n.t("activerecord.attributes.estimate.equipment_20_ot") : "",
      equipment_20_rf ? I18n.t("activerecord.attributes.estimate.equipment_20_rf") : "",
      equipment_20_fr ? I18n.t("activerecord.attributes.estimate.equipment_20_fr") : "",
      equipment_40_dv ? I18n.t("activerecord.attributes.estimate.equipment_40_dv") : "",
      equipment_40_hc ? I18n.t("activerecord.attributes.estimate.equipment_40_hc") : "",
      equipment_40_ot ? I18n.t("activerecord.attributes.estimate.equipment_40_ot") : "",
      equipment_40_rf ? I18n.t("activerecord.attributes.estimate.equipment_40_rf") : "",
      equipment_40_fr ? I18n.t("activerecord.attributes.estimate.equipment_40_fr") : ""
    ].compact.reject(&:blank?).join(", ")
  end

end