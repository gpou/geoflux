class EstimateDetailChrt < EstimateDetail
  self.table_name = 'estimate_details_chrt'

  validates :shipments_per_month, :presence => true, :if => :regular
  validates :shipments_per_month, :numericality => true, :allow_blank => true
  validates :weight, :numericality => true, :allow_blank => true

end