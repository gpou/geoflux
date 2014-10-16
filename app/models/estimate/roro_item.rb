class RoroItem < EstimateItem

  after_initialize :defaults

  def defaults
    self.number_of_items ||= 1
    self.quant_type ||= "quant"
    self.size_type ||= "cubic"
  end

  validates :number_of_items, :presence => true
  validates :weight, :presence => true
  validates :length, :presence => true
  validates :width, :presence => true
  validates :height, :presence => true

end
