class Admin::PortsController < Admin::AdminController


  def index
    @ports = Port.all
  end

end