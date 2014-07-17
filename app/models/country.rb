class Country < ActiveRecord::Base

  has_many :ports
  
  validates :code, :presence => true
  validates :code, uniqueness: true
  validates :name, :presence => true
  
end