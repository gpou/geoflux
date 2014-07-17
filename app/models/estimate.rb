class Estimate < ActiveRecord::Base
  belongs_to :customer
  belongs_to :origin_port, :class_name => 'Port'
  belongs_to :destination_port, :class_name => 'Port'
  belongs_to :origin_country, :class_name => 'Country'
  belongs_to :destination_country, :class_name => 'Country'
  has_many :notes

  validates :customer, :presence => true
  validates :origin_port, :presence => true
  validates :destination_port, :presence => true
  

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

end
