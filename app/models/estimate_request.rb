class EstimateRequest < ActiveRecord::Base
  belongs_to :estimate
  belongs_to :contact

  validates :estimate, :presence => true
  validates :contact, :presence => true

  state_machine :state, :initial => :pending do
    after_transition :on => :send, :do => :set_sent_at
    after_transition :on => :stop_waiting_response, :do => :set_no_response_at
    after_transition :on => :dismiss, :do => :set_dismissed_at
    after_transition :on => :select, :do => :set_selected_at
    after_transition :on => :accept, :do => :set_accepted_at
    event :send
      transition [:pending] => :sent
    end
    event :stop_waiting_response
      transition [:sent] => :no_response
    end
    event :negociate do
      transition [:sent] => :negociating
    end
    event :analyse do
      transition [:sent, :negociating] => :analysing
    end
    event :dismiss do
      transition [:sent, :negociating, :analysing] => :dismissed
    end
    event :select do
      transition [:sent, :negociating, :analysing] => :selected
    end
    event :accept do
      transition [:sent, :negociating, :analysing, :selected] => :accepted
    end
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