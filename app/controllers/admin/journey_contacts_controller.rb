class Admin::JourneyContactsController < Admin::AdminController

  before_filter :find_carrier
  before_filter :find_contact
  before_filter :find_model, :only => %w( edit update destroy)

  
  def index
    @journey_contacts = @contact.journey_contacts
  end

  def new
    @journey_contact = JourneyContact.new(:contact => @contact)
  end

  def create
    @journey_contact = JourneyContact.new journey_contact_parameters
    if @journey_contact.save
      flash[:success] = t("helpers.successfully_created")
      redirect_to admin_carrier_contact_journey_contacts_path(@carrier, @contact)
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @journey_contact.update_attributes journey_contact_parameters
      flash[:success] = t("helpers.successfully_updated")
      redirect_to admin_carrier_contact_journey_contacts_path(@carrier, @contact)
    else
      render :edit
    end
  end

  def destroy
    if @journey_contact.destroy
      flash[:success] = t("helpers.successfully_deleted")
    end
    redirect_to admin_carrier_contact_journey_contacts_path(@carrier, @contact)
  end


  private

    def find_carrier
      @carrier = Carrier.find params[:carrier_id]
    end

    def find_contact
      @contact = Contact.find params[:contact_id]
    end

    def find_model
      @journey_contact = JourneyContact.find params[:id]
    end

    def journey_contact_parameters
      params.require(:journey_contact).permit(:origin_port_id, :destination_port_id, :lcl, :fcl, :roro, :fltk, :cvnl, :chrt, :reefer, :comments).merge(:contact => @contact)
    end

end