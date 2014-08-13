class EstimateDetailFltk < EstimateDetail
  self.table_name = 'estimate_details_fltk'

  belongs_to :origin_country, :class_name => 'Country'
  belongs_to :destination_country, :class_name => 'Country'

end