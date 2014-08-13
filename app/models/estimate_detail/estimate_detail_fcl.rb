class EstimateDetailFcl < EstimateDetail
  self.table_name = 'estimate_details_fcl'

  belongs_to :origin_country, :class_name => 'Country'
  belongs_to :destination_country, :class_name => 'Country'

  validate :origin_address, :presence => true
  validate :origin_zip, :presence => true
  validate :origin_city, :presence => true
  validate :origin_country_id, :presence => true
  validate :origin_complete
  validate :destination_address, :presence => true
  validate :destination_zip, :presence => true
  validate :destination_city, :presence => true
  validate :destination_country_id, :presence => true
  validate :destination_complete
  
  def origin_complete
    if not origin_address.present?
      errors.add(:origin, "#{I18n.t("activerecord.attributes.estimate_detail_fcl.origin_address")} #{I18n.t("errors.messages.blank")}")
    end
    if not origin_zip.present?
      errors.add(:origin, "#{I18n.t("activerecord.attributes.estimate_detail_fcl.origin_zip")} #{I18n.t("errors.messages.blank")}")
    end
    if not origin_city.present?
      errors.add(:origin, "#{I18n.t("activerecord.attributes.estimate_detail_fcl.origin_city")} #{I18n.t("errors.messages.blank")}")
    end
    if not origin_country_id.present?
      errors.add(:origin, "#{I18n.t("activerecord.attributes.estimate_detail_fcl.origin_country_id")} #{I18n.t("errors.messages.blank")}")
    end
  end
  
  def destination_complete
    if not destination_address.present?
      errors.add(:destination, "#{I18n.t("activerecord.attributes.estimate_detail_fcl.destination_address")} #{I18n.t("errors.messages.blank")}")
    end
    if not destination_zip.present?
      errors.add(:destination, "#{I18n.t("activerecord.attributes.estimate_detail_fcl.destination_zip")} #{I18n.t("errors.messages.blank")}")
    end
    if not destination_city.present?
      errors.add(:destination, "#{I18n.t("activerecord.attributes.estimate_detail_fcl.destination_city")} #{I18n.t("errors.messages.blank")}")
    end
    if not destination_country_id.present?
      errors.add(:destination, "#{I18n.t("activerecord.attributes.estimate_detail_fcl.destination_country_id")} #{I18n.t("errors.messages.blank")}")
    end
  end

  validates :shipment_type, :presence => true
  validates :shipments_per_month, :presence => true, :if => lambda { |e| e.shipment_type == "regular" }
  validates :shipments_per_month, :numericality => true, :allow_blank => true
  validates :equipment, :presence => true
  validates :temperature, :presence => true, :if => lambda { |e| e.equipment=="20_rf" or e.equipment=="40_rf" }
  validates :imo_class, :presence => true, :if => :imo
  validates :imo_un, :presence => true, :if => :imo
  validates :oog, :presence => true, :if => lambda { |e| e.equipment=="20_ot" or e.equipment=="20_fr" or e.equipment=="40_ot" or e.equipment=="40_fr" }
  validates :length, :presence => true, :if => lambda { |e| e.oog and(e.equipment=="20_fr" or e.equipment=="40_fr") }
  validates :length, :numericality => true, :allow_blank => true
  validates :width, :presence => true, :if => lambda { |e| e.oog and(e.equipment=="20_fr" or e.equipment=="40_fr") }
  validates :width, :numericality => true, :allow_blank => true
  validates :height, :presence => true, :if => lambda { |e| e.oog and(e.equipment=="20_fr" or e.equipment=="40_fr") }
  validates :height, :numericality => true, :allow_blank => true

  after_initialize :defaults

  def defaults
    self.shipment_type ||= "spot"
    self.imo ||= false
  end

  def origin
    "#{origin_address} #{origin_zip} #{origin_city} #{origin_country ? "(#{origin_country.name})" : ""}"
  end

  def destination
    "#{destination_address} #{destination_zip} #{destination_city} #{destination_country ? "(#{destination_country.name})" : ""}"
  end
end