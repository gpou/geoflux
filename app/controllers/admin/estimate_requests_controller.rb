class Admin::EstimateRequestsController < Admin::AdminController

  before_filter :find_estimate
  before_filter :find_model, :only => %w( show edit update destroy)

  def reload
    type = @estimate.type.downcase
    @contacts = Contact.joins(:journey_contacts).where('journey_contacts.origin_port_id' => @estimate.origin_port_id, 'journey_contacts.destination_port_id' => @estimate.destination_port_id, "journey_contacts.#{@estimate.type.downcase}" => true).uniq
    @contacts.each do |contact|
      r = @estimate.estimate_requests.create(:contact_id => contact.id, :email_content => @estimate.build_email_content)
    end
    redirect_to admin_estimate_path(@estimate)
  end

  def index
    @estimate_requests = @estimate.estimate_requests
  end
  
  def edit
  end
  
  def update
    if @estimate_request.update_attributes estimate_request_parameters
      flash[:success] = t("helpers.successfully_updated")
      redirect_to admin_estimate_path(@estimate)
    else
      render :edit
    end
  end

  def destroy
    if @estimate_request.destroy
      flash[:success] = t("helpers.successfully_deleted")
    end
    redirect_to admin_estimate_path(@estimate)
  end


  private

    def find_estimate
      @estimate = Estimate.find params[:estimate_id]
    end

    def find_model
      @estimate_request = EstimateRequest.find params[:id]
    end

    def estimate_request_parameters
      params.require(:estimate_request).permit(:email_content, :comments).merge(:estimate => @estimate)
    end

end