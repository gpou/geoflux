class Chrt < Estimate

  validates :shipments_per_month, :presence => true, :if => :regular
  validates :shipments_per_month, :numericality => true, :allow_blank => true



end