class Admin::EstimatesController < Admin::AdminController

  before_filter :find_model, :only => %w( edit update destroy)

  def index
    @estimates = Estimate.all
  end

  def new
    @estimate_type = params[:type]
    @estimate = @estimate_type.capitalize.constantize.new
  end

  def create
    @estimate_type = params[:type]
    @estimate = @estimate_type.capitalize.constantize.new estimate_parameters
    if @estimate.save
      flash[:success] = t("helpers.successfully_created")
      redirect_to admin_estimates_path
    else
      render :new
    end
  end

  def edit
    @estimate_type = @estimate.type
  end

  def update
    @estimate_type = @estimate.type
    if @estimate.update_attributes estimate_parameters
      flash[:success] = t("helpers.successfully_updated")
      redirect_to admin_estimates_path
    else
      render :edit
    end
  end


  private

    def find_model
      @estimate = Estimate.find params[:id]
    end

    def estimate_parameters
      params.require(:estimate).permit(:number_of_items, :origin_port_id, :destination_port_id, :customer_id, :origin_address, :origin_city, :origin_zip, :origin_country_id, :destination_address, :destination_city, :destination_zip, :destination_country_id, :description, :shipment_type, :shipments_per_month, :equipment, :temperature, :imo, :imo_class, :imo_un, :stowage_factor, :loading_laytime, :unloading_laytime, :charterer, :estimate_items_attributes => [:id, :_destroy, :number_of_items, :description, :length, :width, :height, :weight])
    end


end