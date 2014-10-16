include ActionView::Helpers::TextHelper

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

  has_many :estimate_requests, :dependent => :destroy

  has_many :estimate_items, :dependent => :destroy, :before_add => :set_items_parent, :autosave => true
  accepts_nested_attributes_for :estimate_items, :allow_destroy => :true
  def set_items_parent(item)
    item.estimate ||= self
  end

  has_one :order


  # VALIDATIONS ******************************************

  validates :customer_id, :presence => true
  validates :origin_port_id, :presence => true
  validates :destination_port_id, :presence => true
  #validate :origin_complete
  #validate :destination_complete

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


  # STATE MACHINE ******************************************

  state_machine :state, :initial => :pending do
    state :pending, :waiting_estimates, :analysing, :sent_to_customer, :negociating_with_customer, :confirmed, :cancelled
    after_transition any => :waiting_estimates, :do => :set_sent_estimate_requests_at
    after_transition any => :analysing, :do => :set_received_estimate_requests_at
    after_transition any => :sent_to_customer, :do => :set_sent_to_customer_at
    after_transition any => :negociating_with_customer, :do => :set_confirmed_at
    after_transition any => :confirmed, :do => :set_confirmed_at
    after_transition any => :cancelled, :do => :set_cancelled_at
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

  after_create :save_email
  
  def save_email
    self.update_columns(:email_content => self.build_email_content, :email_subject => self.build_email_subject) # This will skip validation gracefully.
  end

  # PUBLIC METHODS ******************************************

  def origin
    "#{origin_address} #{origin_zip} #{origin_city} #{origin_province ? " - #{origin_province}" : ""} #{origin_country ? "(#{origin_country.name})" : ""}"
  end

  def destination
    "#{destination_address} #{destination_zip} #{destination_city} #{destination_province ? " - #{destination_province}" : ""} #{destination_country ? "(#{destination_country.name})" : ""}"
  end

  def build_email_content
    "PENDENT"
  end

  def build_email_subject
    "PENDENT"
  end

end
