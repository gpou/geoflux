class Contact < ActiveRecord::Base

  belongs_to :carrier
  has_many :transport_contacts

  validates :email, :presence => true
  validates :email, :format => { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ }
  
end
