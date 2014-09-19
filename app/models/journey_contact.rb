class JourneyContact < ActiveRecord::Base

  belongs_to :origin_port, :class_name => 'Port'
  belongs_to :destination_port, :class_name => 'Port'
  belongs_to :contact
  delegate :carrier, :to => :contact

  validates :origin_port_id, :presence => true
  validates :destination_port_id, :presence => true
  validates :contact, :presence => true

end
