class Lcl < Estimate

  after_initialize :defaults

  def defaults
    self.imo ||= false
  end

  after_initialize :init_first_item

  def init_first_item
    self.estimate_items << LclItem.new if self.estimate_items.none?
  end

  #validate :origin_complete
  #validate :destination_complete

  validates :imo_class, :presence => true, :if => :imo
  validates :imo_un, :presence => true, :if => :imo


  def build_email_content
    if self.origin_city.blank?
      if self.destination_city.blank?
        origin_destination = I18n.t("estimate_request.lcl.email_origin_dest", :origin => self.origin_port.name, :destination => self.destination_port.name)
      else
        origin_destination = I18n.t("estimate_request.lcl.email_origin_dest_delivery", :origin => self.origin_port.name, :destination => self.destination_city)        
      end
    else
      if self.destination_city.blank?
        origin_destination = I18n.t("estimate_request.lcl.email_origin_pickup_dest", :origin => self.origin_city, :destination => self.destination_port.name)
      else
        origin_destination = I18n.t("estimate_request.lcl.email_origin_pickup_dest_delivery", :origin => self.origin_city, :destination => self.destination_city)
      end
    end
    if self.estimate_items.count >1
      txt = I18n.t("estimate_request.lcl.email_content_multiple", :origin_destination => origin_destination)
      txt << "\n"
      self.estimate_items.each do |estimate_item|
        txt << "\n"
        weight = ActionController::Base.helpers.number_to_human(estimate_item.weight, :units => :weight, :precision => 4, :strip_insignificant_zeros => true, :delimiter => ",", :separator => ".", :locale => I18n.locale)
        length = ActionController::Base.helpers.number_to_human(estimate_item.length, :units => :length, :precision => 4, :locale => I18n.locale, :strip_insignificant_zeros => true, :delimiter => ",", :separator => ".")
        width = ActionController::Base.helpers.number_to_human(estimate_item.width, :units => :length, :precision => 4, :locale => I18n.locale, :strip_insignificant_zeros => true, :delimiter => ",", :separator => ".")
        height = ActionController::Base.helpers.number_to_human(estimate_item.height, :units => :length, :precision => 4, :locale => I18n.locale, :strip_insignificant_zeros => true, :delimiter => ",", :separator => ".")
        txt << I18n.t("estimate_request.lcl.email_content_item", :count => estimate_item.number_of_items, :description => estimate_item.description, :description2 => estimate_item.description2, :length => length, :width => width, :height => height, :weight => weight)
      end
    else
      estimate_item = self.estimate_items.first
      weight = ActionController::Base.helpers.number_to_human(estimate_item.weight, :units => :weight, :precision => 4, :strip_insignificant_zeros => true, :delimiter => ",", :separator => ".", :locale => I18n.locale)
      length = ActionController::Base.helpers.number_to_human(estimate_item.length, :units => :length, :precision => 4, :locale => I18n.locale, :strip_insignificant_zeros => true, :delimiter => ",", :separator => ".")
      width = ActionController::Base.helpers.number_to_human(estimate_item.width, :units => :length, :precision => 4, :locale => I18n.locale, :strip_insignificant_zeros => true, :delimiter => ",", :separator => ".")
      height = ActionController::Base.helpers.number_to_human(estimate_item.height, :units => :length, :precision => 4, :locale => I18n.locale, :strip_insignificant_zeros => true, :delimiter => ",", :separator => ".")
      txt = I18n.t("estimate_request.lcl.email_content", :origin_destination => origin_destination, :count => estimate_item.number_of_items, :description => estimate_item.description, :description2 => estimate_item.description2, :length => length, :width => width, :height => height, :weight => weight)
    end
    unless self.origin_address.blank?
      txt << "\n\n"
      txt << I18n.t("estimate_request.lcl.email_origin_address", :address => self.origin_address, :city => self.origin_city, :zip => self.origin_zip, :country => self.origin_country ? self.origin_country.name : "")
    end
    unless self.destination_address.blank?
      txt << "\n\n"
      txt << I18n.t("estimate_request.lcl.email_destination_address", :address => self.destination_address, :city => self.destination_city, :zip => self.destination_zip, :country => self.destination_country ? self.destination_country.name : "")
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
    I18n.t("estimate_request.lcl.email_subject", :origin => orig, :destination => dest)
  end

end