class Fcl < Estimate

  after_initialize :defaults

  def defaults
    self.shipment_type ||= "spot"
    self.imo ||= false
    self.oog ||= false
  end

  after_initialize :init_first_item

  def init_first_item
    self.estimate_items << FclItem.new if self.estimate_items.none?
  end

  validates :shipment_type, :presence => true
  validates :shipments_per_month, :presence => true, :if => lambda { |e| e.shipment_type == "regular" }
  validates :shipments_per_month, :numericality => true, :allow_blank => true
  validates :temperature, :presence => true, :if => lambda { |e| e.equipment_20_rf or e.equipment_40_rf }
  validates :imo_class, :presence => true, :if => :imo
  validates :imo_un, :presence => true, :if => :imo

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

  def build_email_content
    if self.origin_city.blank?
      if self.destination_city.blank?
        origin_destination = I18n.t("estimate_request.fcl.email_origin_dest", :origin => self.origin_port.name, :destination => self.destination_port.name)
      else
        origin_destination = I18n.t("estimate_request.fcl.email_origin_dest_delivery", :origin => self.origin_port.name, :destination => self.destination_city)        
      end
    else
      if self.destination_city.blank?
        origin_destination = I18n.t("estimate_request.fcl.email_origin_pickup_dest", :origin => self.origin_city, :destination => self.destination_port.name)
      else
        origin_destination = I18n.t("estimate_request.fcl.email_origin_pickup_dest_delivery", :origin => self.origin_city, :destination => self.destination_city)
      end
    end
    types = []
    if self.equipment_20_dv
      types << "20dv"
    end
    if self.equipment_20_ot
      types << "20ot"
    end
    if self.equipment_20_rf
      types << "20rf"
    end
    if self.equipment_20_fr
      types << "20fr"
    end
    if self.equipment_40_dv
      types << "40dv"
    end
    if self.equipment_40_hc
      types << "40hc"
    end
    if self.equipment_40_ot
      types << "40ot"
    end
    if self.equipment_40_rf
      types << "40rf"
    end
    if self.equipment_40_fr
      types << "40fr"
    end
    count = I18n.t("estimate_request.fcl.email_count_containers", :count => self.estimate_items.first.number_of_items)
    txt = I18n.t("estimate_request.fcl.email_content", :origin_destination => origin_destination, :count_containers => count, :types => types.join("/"), :description => self.estimate_items.first.description)
    unless self.origin_address.blank?
      txt << "\n\n"
      txt << I18n.t("estimate_request.fcl.email_origin_address", :address => self.origin_address, :city => self.origin_city, :zip => self.origin_zip, :country => self.origin_country ? self.origin_country.name : "")
    end
    unless self.destination_address.blank?
      txt << "\n\n"
      txt << I18n.t("estimate_request.fcl.email_destination_address", :address => self.destination_address, :city => self.destination_city, :zip => self.destination_zip, :country => self.destination_country ? self.destination_country.name : "")
    end
    txt
  end

  def build_email_subject
    unless self.origin_city.blank?
      unless self.origin_province.blank?
        orig = self.origin_province
      else
        orig = self.origin_city
      end
    else
      orig = self.origin_port.name
    end
    unless self.destination_city.blank?
      unless self.destination_province.blank?
        dest = self.destination_province
      else
        dest = self.destination_city
      end
    else
      dest = self.destination_port.name
    end
    I18n.t("estimate_request.fcl.email_subject", :origin => orig, :destination => dest)
  end

end