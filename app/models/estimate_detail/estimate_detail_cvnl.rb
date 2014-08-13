class EstimateDetailCvnl < EstimateDetail
  self.table_name = 'estimate_details_cvnl'

  belongs_to :origin_country, :class_name => 'Country'
  belongs_to :destination_country, :class_name => 'Country'

  after_initialize :init_item
  def init_item
    self.estimate_items << EstimateItem.new if self.estimate_items.none?
  end
  def length
    self.estimate_items.map{|item| item.length}.join("\n")
  end
  def width
    self.estimate_items.map{|item| item.width}.join("\n")
  end
  def height
    self.estimate_items.map{|item| item.height}.join("\n")
  end
  def weight
    self.estimate_items.map{|item| item.weight}.join("\n")
  end
  def description
    self.estimate_items.map{|item| item.description}.join("\n")
  end

end