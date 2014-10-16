class Roro < Estimate

  after_initialize :init_first_item

  def init_first_item
    self.estimate_items << RoroItem.new if self.estimate_items.none?
  end

  def build_email_content
    if self.estimate_items.count == 1
      estimate_item = self.estimate_items.first
      length = ActionController::Base.helpers.number_to_human(estimate_item.length, :units => :length, :precision => 4, :locale => I18n.locale, :strip_insignificant_zeros => true, :delimiter => ",", :separator => ".")
      width = ActionController::Base.helpers.number_to_human(estimate_item.width, :units => :length, :precision => 4, :locale => I18n.locale, :strip_insignificant_zeros => true, :delimiter => ",", :separator => ".")
      height = ActionController::Base.helpers.number_to_human(estimate_item.height, :units => :length, :precision => 4, :locale => I18n.locale, :strip_insignificant_zeros => true, :delimiter => ",", :separator => ".")
      weight = ActionController::Base.helpers.number_to_human(estimate_item.weight, :units => :weight, :precision => 4, :strip_insignificant_zeros => true, :delimiter => ",", :separator => ".", :locale => I18n.locale)
      txt = I18n.t("estimate_request.roro.email_content", :origin => self.origin_port.name, :destination => destination_port.name, :count => estimate_item.number_of_items, :weight => weight, :description => estimate_item.description, :length => length, :width => width, :height => height)
    else
      txt = I18n.t("estimate_request.roro.email_content_multiple", :origin => self.origin_port.name, :destination => destination_port.name)
      txt << "\n"
      self.estimate_items.each do |estimate_item|
        txt << "\n"
        length = ActionController::Base.helpers.number_to_human(estimate_item.length, :units => :length, :precision => 4, :locale => I18n.locale, :strip_insignificant_zeros => true, :delimiter => ",", :separator => ".")
        width = ActionController::Base.helpers.number_to_human(estimate_item.width, :units => :length, :precision => 4, :locale => I18n.locale, :strip_insignificant_zeros => true, :delimiter => ",", :separator => ".")
        height = ActionController::Base.helpers.number_to_human(estimate_item.height, :units => :length, :precision => 4, :locale => I18n.locale, :strip_insignificant_zeros => true, :delimiter => ",", :separator => ".")
        weight = ActionController::Base.helpers.number_to_human(estimate_item.weight, :units => :weight, :precision => 4, :strip_insignificant_zeros => true, :delimiter => ",", :separator => ".", :locale => I18n.locale)
        txt << I18n.t("estimate_request.roro.email_content_item", :count => estimate_item.number_of_items, :description => estimate_item.description, :length => length, :width => width, :height => height, :weight => weight)
      end
    end
    txt
  end

  def build_email_subject
    I18n.t("estimate_request.roro.email_subject", :origin => self.origin_port.name, :destination => destination_port.name)
  end

end