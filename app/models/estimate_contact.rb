class EstimateContact < ActiveRecord::Base
  belongs_to :estimate
  belongs_to :contact

  validates :estimate, :presence => true
end