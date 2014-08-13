class Admin::EstimateDetailsController < Admin::AdminController

  def new
    @estimate_type = params[:type]
    @estimate_detail = "EstimateDetail#{@estimate_type.capitalize}".constantize.new
  end

  def create
    @estimate_type = params[:type]
    @estimate_detail = "EstimateDetail#{@estimate_type.capitalize}".constantize.new permit_params
    if @estimate_detail.save
      #TODO
      flash[:success] = "El pressupost s'ha guardat correctament."
      redirect_to admin_root_path
    else
      render :new
    end
  end

  private

    def permit_params
      params.require(:estimate_detail_fcl).permit(:origin_address, :origin_city, :origin_zip, :origin_country_id, :destination_address, :destination_city, :destination_zip, :destination_country_id, :description, :shipment_type, :shipments_per_month, :equipment, :temperature, :imo, :imo_class, :imo_un, :estimate_attributes => [:number_of_items, :origin_port_id, :destination_port_id, :customer_id])
    end

    def find_model
      @admin = Admin.find params[:id]
    end

end