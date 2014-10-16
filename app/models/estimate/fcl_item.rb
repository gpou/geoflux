class FclItem < EstimateItem

  after_initialize :defaults

  def defaults
    self.number_of_items ||= 1
    self.quant_type ||= "quant"
    self.size_type ||= "cubic"
  end

  validates :number_of_items, :presence => true, :if => lambda { |e| e.quant_type=="quant" and !e.estimate.is_a?(Fltk) }
  validates :number_of_items, :numericality => true, :allow_blank => true

  validates :length, :presence => true, :if => lambda { |e| e.estimate.oog and (e.estimate.equipment_20_fr or e.estimate.equipment_40_fr) }
  validates :width, :presence => true, :if => lambda { |e| e.estimate.oog and (e.estimate.equipment_20_fr or e.estimate.equipment_40_fr) }
  validates :height, :presence => true, :if => lambda { |e| e.estimate.oog and (e.estimate.equipment_20_fr or e.estimate.equipment_40_fr or e.estimate.equipment_20_ot or e.estimate.equipment_40_ot) }

end
