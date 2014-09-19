class Admin::ContactsController < Admin::AdminController

  before_filter :find_carrier
  before_filter :find_model, :only => %w( show edit update destroy)

  
  def index
    @contacts = @carrier.contacts
  end

  def new
    @contact = Contact.new(:carrier => @carrier)
  end

  def create
    @contact = Contact.new contact_parameters
    if @contact.save
      flash[:success] = t("helpers.successfully_created")
      redirect_to admin_carrier_contacts_path(@carrier)
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @contact.update_attributes contact_parameters
      flash[:success] = t("helpers.successfully_updated")
      redirect_to admin_carrier_contacts_path(@carrier)
    else
      render :edit
    end
  end

  def destroy
    if @contact.destroy
      flash[:success] = t("helpers.successfully_deleted")
    end
    redirect_to admin_carrier_contacts_path(@carrier)
  end


  private

    def find_carrier
      @carrier = Carrier.find params[:carrier_id]
    end

    def find_model
      @contact = Contact.find params[:id]
    end

    def contact_parameters
      params.require(:contact).permit(:email, :first_name, :last_name, :phone, :comments).merge(:carrier => @carrier)
    end

end