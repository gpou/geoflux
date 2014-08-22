class EstimateItem < ActiveRecord::Base

  belongs_to :estimate


  # GENERIC VALIDATIONS ******************************************

  validates :number_of_items, :presence => true
  validates :number_of_items, :numericality => true, :allow_blank => true
  validates :description, :presence => true


  # LCL, RORO, CVNL, CHRT VALIDATIONS ******************************************

  validates :length, :presence => true, :if => lambda { |e| e.estimate.is_a?(Lcl) or e.estimate.is_a?(Roro) or e.estimate.is_a?(Cvnl) }
  validates :length, :numericality => true, :allow_blank => true, :if => lambda { |e| e.estimate.is_a?(Lcl) or e.estimate.is_a?(Roro) or e.estimate.is_a?(Cvnl) }
  validates :width, :presence => true, :if => lambda { |e| e.estimate.is_a?(Lcl) or e.estimate.is_a?(Roro) or e.estimate.is_a?(Cvnl) }
  validates :width, :numericality => true, :allow_blank => true, :if => lambda { |e| e.estimate.is_a?(Lcl) or e.estimate.is_a?(Roro) or e.estimate.is_a?(Cvnl) }
  validates :height, :presence => true, :if => lambda { |e| e.estimate.is_a?(Lcl) or e.estimate.is_a?(Roro) or e.estimate.is_a?(Cvnl) }
  validates :height, :numericality => true, :allow_blank => true, :if => lambda { |e| e.estimate.is_a?(Lcl) or e.estimate.is_a?(Roro) or e.estimate.is_a?(Cvnl) }
  validates :weight, :presence => true, :if => lambda { |e| e.estimate.is_a?(Lcl) or e.estimate.is_a?(Roro) or e.estimate.is_a?(Cvnl) or e.estimate.is_a?(Chrt) }
  validates :weight, :numericality => true, :allow_blank => true, :if => lambda { |e| e.estimate.is_a?(Lcl) or e.estimate.is_a?(Roro) or e.estimate.is_a?(Cvnl) or e.estimate.is_a?(Chrt) }


  # FCL VALIDATIONS ******************************************

  validates :length, :presence => true, :if => lambda { |e| e.estimate.is_a?(Fcl) and (e.estimate.equipment=="20_fr" or e.estimate.equipment=="40_fr") }
  validates :length, :numericality => true, :allow_blank => true, :if => lambda { |e| e.estimate.is_a?(Fcl) and (e.estimate.equipment=="20_fr" or e.estimate.equipment=="40_fr") }
  validates :width, :presence => true, :if => lambda { |e| e.estimate.is_a?(Fcl) and (e.estimate.equipment=="20_fr" or e.estimate.equipment=="40_fr") }
  validates :width, :numericality => true, :allow_blank => true, :if => lambda { |e| (e.estimate.is_a?(Fcl) and e.estimate.equipment=="20_fr" or e.estimate.equipment=="40_fr") }
  validates :height, :presence => true, :if => lambda { |e| e.estimate.is_a?(Fcl) and (e.estimate.equipment=="20_fr" or e.estimate.equipment=="40_fr" or e.estimate.equipment=="20_ot" or e.estimate.equipment=="40_ot") }
  validates :height, :numericality => true, :allow_blank => true, :if => lambda { |e| (e.estimate.is_a?(Fcl) and e.estimate.equipment=="20_fr" or e.estimate.equipment=="40_fr" or e.estimate.equipment=="20_ot" or e.estimate.equipment=="40_ot") }

end