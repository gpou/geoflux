class EstimateItem < ActiveRecord::Base

  belongs_to :estimate


  validates :description, :presence => true
  validates :number_of_items, :numericality => true, :allow_blank => true
  validates :length, :numericality => true, :allow_blank => true
  validates :width, :numericality => true, :allow_blank => true
  validates :height, :numericality => true, :allow_blank => true
  validates :diameter, :numericality => true, :allow_blank => true
  validates :weight, :numericality => true, :allow_blank => true


end