class ChrtItem < EstimateItem

  after_initialize :defaults

  def defaults
    self.quant_type ||= "weight"
  end

  validates :weight, :presence => true

end
