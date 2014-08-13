class Customer < ActiveRecord::Base
  has_many :estimates
  belongs_to :invoice_country, :class_name => 'Country'

  validates :phone, :presence => true
  validates :email, :presence => true
  validates :email, :format => { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ }

  def full_name
    "#{email} #{company} #{last_name} #{first_name}"
  end
end