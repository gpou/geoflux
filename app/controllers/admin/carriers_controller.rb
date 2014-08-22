class Admin::CarriersController < Admin::AdminController

  before_filter :find_model, :only => %w( edit update destroy)

  
  def index
    @carriers = Carrier.all
  end

  def new
    @carrier = Carrier.new
  end

  def create
    @carrier = Carrier.new carrier_parameters
    if @carrier.save
      flash[:success] = t("helpers.successfully_created")
      redirect_to admin_carriers_path
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @carrier.update_attributes carrier_parameters
      flash[:success] = t("helpers.successfully_updated")
      redirect_to admin_carriers_path
    else
      render :edit
    end
  end

  def destroy
    if @carrier.destroy
      flash[:success] = t("helpers.successfully_deleted")
    end
    redirect_to admin_carriers_path
  end


  private

    def find_model
      @carrier = Carrier.find params[:id]
    end

    def carrier_parameters
      params.require(:carrier).permit(:acronym, :name, :invoice_name, :invoice_nif, :invoice_street, :invoice_city, :invoice_zip, :invoice_country_id, :comments)
    end

end