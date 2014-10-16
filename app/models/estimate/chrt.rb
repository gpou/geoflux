class Chrt < Estimate

  after_initialize :defaults

  def defaults
    self.shipment_type ||= "spot"
  end

  after_initialize :init_first_item

  def init_first_item
    self.estimate_items << ChrtItem.new if self.estimate_items.none?
  end

  validates :shipments_per_month, :presence => true, :if => lambda { |e| e.shipment_type == "regular" }
  validates :shipments_per_month, :numericality => true, :allow_blank => true

  def build_email_content
    if self.shipment_type == 'regular'
      txt = I18n.t("estimate_request.chrt.email_content_regular", :origin => self.origin_port.name, :destination => destination_port.name, :weight => ActionController::Base.helpers.number_to_human(self.estimate_items.first.weight, :units => :weight, :precision => 4, :locale => I18n.locale), :description => self.estimate_items.first.description)
      txt << I18n.t("estimate_request.chrt.email_content_shipments", :count => self.shipments_per_month)
    else
      txt = I18n.t("estimate_request.chrt.email_content_spot", :origin => self.origin_port.name, :destination => destination_port.name, :weight => ActionController::Base.helpers.number_to_human(self.estimate_items.first.weight, :units => :weight, :precision => 4, :locale => I18n.locale), :description => self.estimate_items.first.description)
    end
    unless self.stowage_factor.blank?
      txt << I18n.t("estimate_request.chrt.email_content_stowage_factor", :stowage_factor => self.stowage_factor)
    end
    unless self.loading_laytime.blank?
      if self.loading_laytime==self.unloading_laytime or self.unloading_laytime.blank
        txt << I18n.t("estimate_request.chrt.email_content_laytime", :laytime => self.loading_laytime)
      else
        txt << I18n.t("estimate_request.chrt.email_content_laytimes", :loading_laytime => self.loading_laytime, :unloading_laytime => self.unloading_laytime)
      end
    end
    txt
  end

  def build_email_subject
    I18n.t("estimate_request.chrt.email_subject", :origin => self.origin_port.name, :destination => destination_port.name)
  end


end