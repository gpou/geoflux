class EstimateRequest < ActiveRecord::Base
  belongs_to :estimate
  belongs_to :contact

  delegate :carrier, :to => :contact
  
  validates :estimate, :presence => true
  validates :contact, :presence => true

  state_machine :state, :initial => :pending do
    state :pending, :sent, :analysing, :negociating, :no_response, :dismissed, :selected, :accepted
    after_transition any => :sent, :do => :set_sent_at
    after_transition any => :no_response, :do => :set_no_response_at
    after_transition any => :dismissed, :do => :set_dismissed_at
    after_transition any => :selected, :do => :set_selected_at
    after_transition any => :accepted, :do => :set_accepted_at
    event :send_request do
      transition all => :sent
    end
  end

  def copy_email_from_estimate
    self.update_columns(:email_subject => self.estimate.email_subject, :email_content => self.estimate.email_content, :email_additional_content => self.estimate.email_additional_content)
  end

  def email_like_estimate?
    self.email_subject==self.estimate.email_subject and self.email_content==self.estimate.email_content and self.email_additional_content==self.estimate.email_additional_content
  end

  def set_sent_at
    self.sent_at = Time.now
    self.save
  end

  def set_no_response_at
    self.no_response_at = Time.now
    self.save
  end

  def set_dismissed_at
    self.dismissed_at = Time.now
    self.save
  end

  def set_selected_at
    self.selected_at = Time.now
    self.save
  end

  def set_accepted_at
    self.accepted_at = Time.now
    self.save
  end

end