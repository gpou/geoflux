class JourneyContact < ActiveRecord::Base

  belongs_to :origin_port, :class_name => 'Port'
  belongs_to :destination_port, :class_name => 'Port'
  belongs_to :contact

  validates :origin_port, :presence => true
  validates :destination_port, :presence => true
  validates :contact, :presence => true

end
