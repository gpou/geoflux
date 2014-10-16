class Order < ActiveRecord::Base

  scope :LCL, -> { where(type: 'Lcl') } 
  scope :FCL, -> { where(type: 'Fcl') } 
  scope :RORO, -> { where(type: 'Roro') } 
  scope :FLTK, -> { where(type: 'Fltk') } 
  scope :CVNL, -> { where(type: 'Cvnl') } 
  scope :CHRT, -> { where(type: 'Chrt') } 

  belongs_to :estimate
  belongs_to :carrier
  belongs_to :contact

  belongs_to :customer
  belongs_to :origin_port, :class_name => 'Port'
  belongs_to :destination_port, :class_name => 'Port'

  belongs_to :origin_country, :class_name => 'Country'
  belongs_to :destination_country, :class_name => 'Country'


  has_many :order_items, :dependent => :destroy, :before_add => :set_items_parent, :autosave => true
  accepts_nested_attributes_for :order_items, :allow_destroy => :true
  def set_items_parent(item)
    item.order ||= self
  end

  # VALIDATIONS ******************************************

  validates :estimate_id, :presence => true
  validates :carrier_id, :presence => true
  validates :customer_id, :presence => true
  validates :origin_port_id, :presence => true
  validates :destination_port_id, :presence => true
  validates :date, :presence => true
  validates :price, :numericality => true, :allow_blank => true


  # STATE MACHINE ******************************************

  state_machine :state, :initial => :pending do
    state :pending, :started, :finished, :paid, :cancelled
    after_transition any => :started, :do => :set_started_at
    after_transition any => :finished, :do => :set_finished_at
    after_transition any => :paid, :do => :set_paid_at
    after_transition any => :cancelled, :do => :set_cancelled_at
  end

  def set_started_at
    self.started_at = Time.now
    self.save
  end

  def set_finished_at
    self.finished_at = Time.now
    self.save
  end

  def set_paid_at
    self.paid_at = Time.now
    self.save
  end

  def set_cancelled_at
    self.cancelled_at = Time.now
    self.save
  end


  # CREATE ORDER FROM ESTIMATE ******************************************

  def save_estimate(estimate_request)
    estimate = estimate_request.estimate

    self.date = Time.now
    self.order_type = estimate.type
    self.estimate = estimate
    self.customer = estimate.customer
    self.carrier = estimate_request.carrier
    self.contact = estimate_request.contact
    self.origin_port = estimate.origin_port
    self.destination_port = estimate.destination_port
    self.origin_address = estimate.origin_address
    self.origin_city = estimate.origin_city
    self.origin_province = estimate.origin_province
    self.origin_zip = estimate.origin_zip
    self.origin_country = estimate.origin_country
    self.destination_address = estimate.destination_address
    self.destination_city = estimate.destination_city
    self.destination_province = estimate.destination_province
    self.destination_zip = estimate.destination_zip
    self.destination_country = estimate.destination_country
    self.imo = estimate.imo
    self.imo_class = estimate.imo_class
    self.imo_un = estimate.imo_un
    self.shipment_type = estimate.shipment_type
    self.shipments_per_month = estimate.shipments_per_month
    self.equipment_20_dv = estimate.equipment_20_dv
    self.equipment_20_ot = estimate.equipment_20_ot
    self.equipment_20_rf = estimate.equipment_20_rf
    self.equipment_20_fr = estimate.equipment_20_fr
    self.equipment_40_dv = estimate.equipment_40_dv
    self.equipment_40_hc = estimate.equipment_40_hc
    self.equipment_40_rf = estimate.equipment_40_rf
    self.equipment_40_fr = estimate.equipment_40_fr
    self.temperature = estimate.temperature
    self.stowage_factor = estimate.stowage_factor
    self.loading_laytime = estimate.loading_laytime
    self.unloading_laytime = estimate.unloading_laytime
    self.charterer = estimate.charterer
    self.email_subject = estimate_request.email_subject
    self.email_content = estimate_request.email_content
    self.email_additional_content = estimate_request.email_additional_content
    self.comments = (!estimate.comments.blank? ? estimate.comments : "")
    if not estimate.comments.blank? and not estimate_request.comments.blank?
      self.comments << "\n\n"
    end
    self.comments << (!estimate_request.comments.blank? ? estimate_request.comments : "")
    self.save!

    estimate.estimate_items.each do |estimate_item|
      order_item = self.order_items.build
      order_item.estimate_item = estimate_item
      order_item.quant_type = estimate_item.quant_type
      order_item.number_of_items = estimate_item.number_of_items
      order_item.weight = estimate_item.weight
      order_item.size_type = estimate_item.size_type
      order_item.length = estimate_item.length
      order_item.width = estimate_item.width
      order_item.height = estimate_item.height
      order_item.diameter = estimate_item.diameter
      order_item.description = estimate_item.description
      order_item.description2 = estimate_item.description2
#      order_item.save!
      self.order_items << order_item
    end
    self.save!
  end

  def origin
    "#{origin_address} #{origin_zip} #{origin_city} #{origin_province ? " - #{origin_province}" : ""} #{origin_country ? "(#{origin_country.name})" : ""}"
  end

  def destination
    "#{destination_address} #{destination_zip} #{destination_city} #{destination_province ? " - #{destination_province}" : ""} #{destination_country ? "(#{destination_country.name})" : ""}"
  end

end