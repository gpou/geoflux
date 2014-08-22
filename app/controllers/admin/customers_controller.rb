class Admin::CustomersController < Admin::AdminController

  before_filter :find_model, :only => %w( edit update destroy)
  
  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new customer_parameters
    if @customer.save
      flash[:success] = t("helpers.successfully_created")
      redirect_to admin_customers_path
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @customer.update_attributes customer_parameters
      flash[:success] = t("helpers.successfully_updated")
      redirect_to admin_customers_path
    else
      render :edit
    end
  end

  def destroy
    if @customer.destroy
      flash[:success] = t("helpers.successfully_deleted")
    end
    redirect_to admin_customers_path
  end


  private

    def find_model
      @customer = Customer.find params[:id]
    end

    def customer_parameters
      params.require(:customer).permit(:company, :first_name, :last_name, :email, :phone, :invoice_name, :invoice_nif, :invoice_street, :invoice_city, :invoice_zip, :invoice_country_id, :comments)
    end

end