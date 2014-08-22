class Fcl < Estimate

  after_initialize :defaults

  def defaults
    self.shipment_type ||= "spot"
    self.imo ||= false
  end

  #validate :origin_complete
  #validate :destination_complete
  validates :shipment_type, :presence => true
  validates :shipments_per_month, :presence => true, :if => lambda { |e| e.shipment_type == "regular" }
  validates :shipments_per_month, :numericality => true, :allow_blank => true
  validates :equipment, :presence => true
  validates :temperature, :presence => true, :if => lambda { |e| e.equipment=="20_rf" or e.equipment=="40_rf" }
  validates :imo_class, :presence => true, :if => :imo
  validates :imo_un, :presence => true, :if => :imo
  validates :oog, :presence => true, :if => lambda { |e| e.equipment=="20_ot" or e.equipment=="20_fr" or e.equipment=="40_ot" or e.equipment=="40_fr" }

  def origin_complete
    if not origin_address.present?
      errors.add(:origin, "#{I18n.t("activerecord.attributes.estimate.origin_address")} #{I18n.t("errors.messages.blank")}")
    end
    if not origin_zip.present?
      errors.add(:origin, "#{I18n.t("activerecord.attributes.estimate.origin_zip")} #{I18n.t("errors.messages.blank")}")
    end
    if not origin_city.present?
      errors.add(:origin, "#{I18n.t("activerecord.attributes.estimate.origin_city")} #{I18n.t("errors.messages.blank")}")
    end
    if not origin_country_id.present?
      errors.add(:origin, "#{I18n.t("activerecord.attributes.estimate.origin_country_id")} #{I18n.t("errors.messages.blank")}")
    end
  end
  
  def destination_complete
    if not destination_address.present?
      errors.add(:destination, "#{I18n.t("activerecord.attributes.estimate.destination_address")} #{I18n.t("errors.messages.blank")}")
    end
    if not destination_zip.present?
      errors.add(:destination, "#{I18n.t("activerecord.attributes.estimate.destination_zip")} #{I18n.t("errors.messages.blank")}")
    end
    if not destination_city.present?
      errors.add(:destination, "#{I18n.t("activerecord.attributes.estimate.destination_city")} #{I18n.t("errors.messages.blank")}")
    end
    if not destination_country_id.present?
      errors.add(:destination, "#{I18n.t("activerecord.attributes.estimate.destination_country_id")} #{I18n.t("errors.messages.blank")}")
    end
  end


  def origin
    "#{origin_address} #{origin_zip} #{origin_city} #{origin_country ? "(#{origin_country.name})" : ""}"
  end

  def destination
    "#{destination_address} #{destination_zip} #{destination_city} #{destination_country ? "(#{destination_country.name})" : ""}"
  end
end