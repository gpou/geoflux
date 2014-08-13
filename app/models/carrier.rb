class Carrier < ActiveRecord::Base

  has_many :contacts
  belongs_to :invoice_country, :class_name => 'Country'

  validates :acronym, :presence => true
  validates :name, :presence => true
  
end
