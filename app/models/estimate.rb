class Estimate < ActiveRecord::Base

  scope :LCL, -> { where(type: 'Lcl') } 
  scope :FCL, -> { where(type: 'Fcl') } 
  scope :RORO, -> { where(type: 'Roro') } 
  scope :FLTK, -> { where(type: 'Fltk') } 
  scope :CVNL, -> { where(type: 'Cvnl') } 
  scope :CHRT, -> { where(type: 'Chrt') } 

  belongs_to :customer
  belongs_to :origin_port, :class_name => 'Port'
  belongs_to :destination_port, :class_name => 'Port'

  belongs_to :origin_country, :class_name => 'Country'
  belongs_to :destination_country, :class_name => 'Country'

  has_many :estimate_items, :dependent => :destroy, :before_add => :set_items_parent, :autosave => true
  accepts_nested_attributes_for :estimate_items, :allow_destroy => :true
  def set_items_parent(item)
    item.estimate ||= self
  end



  # VALIDATIONS ******************************************

  validates :customer_id, :presence => true
  validates :origin_port_id, :presence => true
  validates :destination_port_id, :presence => true


  # STATE MACHINE ******************************************

  state_machine :state, :initial => :pending do
    after_transition :on => :send_estimate_requests, :do => :set_sent_estimate_requests_at
    after_transition :on => :received_estimate_requests, :do => :set_received_estimate_requests_at
    after_transition :on => :send_to_customer, :do => :set_sent_to_customer_at
    after_transition :on => :confirm, :do => :set_confirmed_at
    after_transition :on => :cancel, :do => :set_cancelled_at

    event :send_estimate_requests do
      transition [:pending] => :waiting_estimates
    end
    event :received_estimate_requests do
      transition [:waiting_estimates] => :analysing
    end
    event :send_to_customer do
      transition [:analysing] => :sent_to_customer
    end
    event :negociate do
      transition [:sent_to_customer] => :negociating_with_customer
    end
    event :confirm do
      transition [:sent_to_customer, :negociating_with_customer] => :confirmed
    end
    event :cancel do
      transition [:sent_to_customer, :negociating_with_customer] => :cancelled
    end
  end

  def set_sent_estimate_requests_at
    self.sent_estimate_requests_at = Time.now
    self.save
  end

  def set_received_estimate_requests_at
    self.received_estimate_requests_at = Time.now
    self.save
  end

  def set_sent_to_customer_at
    self.sent_to_customer_at = Time.now
    self.save
  end

  def set_confirmed_at
    self.confirmed_at = Time.now
    self.save
  end

  def set_cancelled_at
    self.cancelled_at = Time.now
    self.save
  end


  # INITIALIZATIONS ******************************************

  after_initialize :init_customer

  def init_customer
    self.build_customer if self.customer.nil?
  end

  after_initialize :defaults

  def defaults
    self.number_of_items ||= 1
  end

  after_initialize :init_first_item

  def init_first_item
    self.estimate_items << EstimateItem.new if self.estimate_items.none?
  end

  after_validation :set_number_of_items
  
  def set_number_of_items
    self.number_of_items = self.estimate_items.sum(:number_of_items)
  end

  # PUBLIC METHODS ******************************************

  def origin
    "#{origin_address} #{origin_zip} #{origin_city} #{origin_country ? "(#{origin_country.name})" : ""}"
  end

  def destination
    "#{destination_address} #{destination_zip} #{destination_city} #{destination_country ? "(#{destination_country.name})" : ""}"
  end

end
