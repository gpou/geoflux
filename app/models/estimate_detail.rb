class EstimateDetail < ActiveRecord::Base
  self.abstract_class = true

  has_one :estimate, :as => :estimateable, dependent: :destroy, :autosave => true
  accepts_nested_attributes_for :estimate

  has_many :estimate_items, :as => :estimateable, dependent: :destroy, :autosave => true

  validates :estimate, presence: true

  after_initialize :init_estimate
  def init_estimate
    self.build_estimate if self.estimate.nil?
  end

end