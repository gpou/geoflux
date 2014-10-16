class Fltk < Estimate

  after_initialize :init_first_item

  def init_first_item
    self.estimate_items << FltkItem.new if self.estimate_items.none?
  end

  #validate :origin_complete
  #validate :destination_complete

  def build_email_content
    txt = I18n.t("estimate_request.fltk.email_content", :origin => self.origin_port.name, :destination => destination_port.name, :count => self.estimate_items.first.number_of_items, :description => self.estimate_items.first.description)
    txt
  end

  def build_email_subject
    I18n.t("estimate_request.cvnl.email_subject", :origin => self.origin_port.name, :destination => destination_port.name)
  end


end