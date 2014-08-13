class Admin::AdminController < ApplicationController

  #before_filter :authenticate_admin!
  before_filter :set_locale
  layout 'admin'

  def set_locale
    I18n.locale = :ca
  end

end
