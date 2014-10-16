class Cvnl < Estimate

  after_initialize :init_first_item

  def init_first_item
    self.estimate_items << CvnlItem.new if self.estimate_items.none?
  end

  #validate :origin_complete
  #validate :destination_complete

  def build_email_content
    if self.estimate_items.count == 1
      estimate_item = self.estimate_items.first
      weight = ActionController::Base.helpers.number_to_human(estimate_item.weight, :units => :weight, :precision => 4, :strip_insignificant_zeros => true, :delimiter => ",", :separator => ".", :locale => I18n.locale)
      length = ActionController::Base.helpers.number_to_human(estimate_item.length, :units => :length, :precision => 4, :locale => I18n.locale, :strip_insignificant_zeros => true, :delimiter => ",", :separator => ".")
      width = ActionController::Base.helpers.number_to_human(estimate_item.width, :units => :length, :precision => 4, :locale => I18n.locale, :strip_insignificant_zeros => true, :delimiter => ",", :separator => ".")
      height = ActionController::Base.helpers.number_to_human(estimate_item.height, :units => :length, :precision => 4, :locale => I18n.locale, :strip_insignificant_zeros => true, :delimiter => ",", :separator => ".")
      diameter = ActionController::Base.helpers.number_to_human(estimate_item.diameter, :units => :length, :precision => 4, :locale => I18n.locale, :strip_insignificant_zeros => true, :delimiter => ",", :separator => ".")
      if estimate_item.size_type=="cylindric"
        if estimate_item.quant_type=="weight"
          txt = I18n.t("estimate_request.cvnl.email_content_weight_cylinder", :origin => self.origin_port.name, :destination => destination_port.name, :weight => weight, :description => estimate_item.description, :diameter => diameter, :height => height)
        else
          txt = I18n.t("estimate_request.cvnl.email_content_cylinder", :count => estimate_item.number_of_items, :origin => self.origin_port.name, :destination => destination_port.name, :weight => weight, :description => estimate_item.description, :diameter => diameter, :height => height)
        end
      else
        if estimate_item.quant_type=="weight"
          txt = I18n.t("estimate_request.cvnl.email_content_weight", :origin => self.origin_port.name, :destination => destination_port.name, :weight => weight, :description => estimate_item.description, :length => length, :width => width, :height => height)
        else
          txt = I18n.t("estimate_request.cvnl.email_content", :count => estimate_item.number_of_items, :origin => self.origin_port.name, :destination => destination_port.name, :weight => weight, :description => estimate_item.description, :length => length, :width => width, :height => height)
        end
      end
    else
      txt = I18n.t("estimate_request.cvnl.email_content_multiple", :origin => self.origin_port.name, :destination => destination_port.name)
      txt << "\n"
      self.estimate_items.each do |estimate_item|
        txt << "\n"
        weight = ActionController::Base.helpers.number_to_human(estimate_item.weight, :units => :weight, :precision => 4, :strip_insignificant_zeros => true, :delimiter => ",", :separator => ".", :locale => I18n.locale)
        length = ActionController::Base.helpers.number_to_human(estimate_item.length, :units => :length, :precision => 4, :locale => I18n.locale, :strip_insignificant_zeros => true, :delimiter => ",", :separator => ".")
        height = ActionController::Base.helpers.number_to_human(estimate_item.height, :units => :length, :precision => 4, :locale => I18n.locale, :strip_insignificant_zeros => true, :delimiter => ",", :separator => ".")
        diameter = ActionController::Base.helpers.number_to_human(estimate_item.diameter, :units => :length, :precision => 4, :locale => I18n.locale, :strip_insignificant_zeros => true, :delimiter => ",", :separator => ".")
        if estimate_item.size_type=="cylindric"
          if estimate_item.quant_type=="weight"
            txt << I18n.t("estimate_request.cvnl.email_content_item_weight_cylinder", :description => estimate_item.description, :diameter => diameter, :height => height, :weight => weight)
          else
            txt << I18n.t("estimate_request.cvnl.email_content_item_cylinder", :count => estimate_item.number_of_items, :description => estimate_item.description, :diameter => diameter, :height => height, :weight => weight)
          end
        else
          if estimate_item.quant_type=="weight"
            txt << I18n.t("estimate_request.cvnl.email_content_item_weight", :description => estimate_item.description, :length => length, :width => width, :height => height, :weight => weight)
          else
            txt << I18n.t("estimate_request.cvnl.email_content_item", :count => estimate_item.number_of_items, :description => estimate_item.description, :length => length, :width => width, :height => height, :weight => weight)
          end
        end
      end
    end
    txt
  end

  def build_email_subject
    I18n.t("estimate_request.cvnl.email_subject", :origin => self.origin_port.name, :destination => destination_port.name)
  end

end