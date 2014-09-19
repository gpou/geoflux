class Contact < ActiveRecord::Base

  belongs_to :carrier
  has_many :journey_contacts, :dependent => :destroy, :before_add => :set_journey_contacts_parent, :autosave => true
  accepts_nested_attributes_for :journey_contacts, :allow_destroy => :true
  def set_journey_contacts_parent(item)
    item.contact ||= self
  end
  has_many :estimate_requests

  validates :first_name, :presence => true
  validates :email, :presence => true
  validates :email, :format => { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ }
  validates :email, uniqueness: { case_sensitive: false }
  
  def to_s
    email
  end

end
