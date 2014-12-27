class CvnlItem < EstimateItem

  after_initialize :defaults

  def defaults
    self.quant_type ||= "quant"
    self.size_type ||= "cubic"
  end

  validates :number_of_items, :presence => true, :if => lambda { |e| e.quant_type=="quant" }
  validates :weight, :presence => true, :if => lambda { |e| e.quant_type=="weight" }
  validates :length, :presence => true, :if => lambda { |e| e.size_type=="cubic" }
  validates :width, :presence => true, :if => lambda { |e| e.size_type=="cubic" }
  validates :diameter, :presence => true, :if => lambda { |e| e.size_type=="cylindric" }
  validates :height, :presence => true

end
