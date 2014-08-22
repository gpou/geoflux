class Admin::PortsController < Admin::AdminController

  before_filter :find_model, :only => %w( edit update destroy)

  
  def index
    @ports = Port.all
  end

  def new
    @port = Port.new
  end

  def create
    @port = Port.new port_parameters
    if @port.save
      flash[:success] = t("helpers.successfully_created")
      redirect_to admin_ports_path
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @port.update_attributes port_parameters
      flash[:success] = t("helpers.successfully_updated")
      redirect_to admin_ports_path
    else
      render :edit
    end
  end

  def destroy
    if @port.destroy
      flash[:success] = t("helpers.successfully_deleted")
    end
    redirect_to admin_ports_path
  end


  private

    def find_model
      @port = Port.find params[:id]
    end

    def port_parameters
      params.require(:port).permit(:country_id, :code, :name, :comments)
    end


end