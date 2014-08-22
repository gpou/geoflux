class Lcl < Estimate

  #validate :origin_complete
  #validate :destination_complete

  validates :imo_class, :presence => true, :if => :imo
  validates :imo_un, :presence => true, :if => :imo


end