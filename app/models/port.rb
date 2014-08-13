class Port < ActiveRecord::Base
  default_scope { order('name') } 
  belongs_to :country

  validates :country, :presence => true
  validates :code, :presence => true
  validates :code, uniqueness: true
  validates :name, :presence => true
  
end
