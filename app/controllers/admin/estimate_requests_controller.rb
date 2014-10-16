class Admin::EstimateRequestsController < Admin::AdminController

  before_filter :find_estimate
  before_filter :find_model, :except => %w( index )

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

  def send_request
    if @estimate_request.send_request
      UserMailer.estimate_request(@estimate_request).deliver
      flash[:success] = t("estimate_request.successfully_sent_request")
    end
    redirect_to admin_estimate_path(@estimate)
  end

  def change_state
    unless params[:state].blank?
      @estimate_request.state = params[:state]
      @estimate_request.save
    end
    redirect_to admin_estimate_path(@estimate)
  end

  def reload_email
    flash[:success] = t("helpers.successfully_updated")
    @estimate_request.copy_email_from_estimate
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
      params.require(:estimate_request).permit(:state, :email_subject, :email_content, :email_additional_content, :comments).merge(:estimate => @estimate)
    end

end