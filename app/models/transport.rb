class Transport < ActiveRecord::Base
  belongs_to :estimate
  belongs_to :customer
  belongs_to :origin_port, :class_name => 'Port'
  belongs_to :destination_port, :class_name => 'Port'
  belongs_to :origin_country, :class_name => 'Country'
  belongs_to :destination_country, :class_name => 'Country'
  has_many :notes

  validates :estimate, :presence => true
  validates :customer, :presence => true
  validates :origin_port, :presence => true
  validates :destination_port, :presence => true
  

  state_machine :state, :initial => :pending do
    after_transition :on => :start, :do => :set_started_at
    after_transition :on => :arrive, :do => :set_arrived_at

    event :start do
      transition [:pending] => :started
    end
    event :arrive do
      transition [:started, :pending] => :arrived
    end
  end

  def set_started_at
    self.started_at = Time.now
    self.save
  end

  def set_arrived_at
    self.arrived_at = Time.now
    self.save
  end
  
end
