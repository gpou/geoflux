class Admin::EstimatesController < Admin::AdminController

  before_filter :find_model, :except => %w( index new create )

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
      redirect_to admin_estimate_path(@estimate)
    else
      puts @estimate.estimate_items.first.quant_type
      puts @estimate.estimate_items.first.size_type
      puts @estimate.errors.inspect
      render :new
    end
  end

  def show
    @contacts = Contact.joins(:journey_contacts).where('journey_contacts.origin_port_id' => @estimate.origin_port_id, 'journey_contacts.destination_port_id' => @estimate.destination_port_id, "journey_contacts.#{@estimate.type.downcase}" => true)
    if @estimate.is_a?(Fcl) and (@estimate.equipment_20_rf or @estimate.equipment_40_rf)
      @contacts = @contacts.where('journey_contacts.reefer' => true)
    end
    if @estimate.estimate_requests.any?
      @contacts = @contacts.where('contacts.id NOT IN (?)',@estimate.estimate_requests.map{|r| r.contact_id})
      puts @contacts.to_sql
    end
    @contacts = @contacts.uniq
  end

  def add_estimate_requests
    num_added = 0
    if params[:contact_ids]
      params[:contact_ids].each do |contact_id|
        if @estimate.estimate_requests.where(:contact_id => contact_id).count == 0
          estimate_request = @estimate.estimate_requests.create(:contact_id => contact_id)
          if estimate_request
            estimate_request.copy_email_from_estimate
            num_added = num_added + 1
          end
        end
      end
    end
    flash[:success] = t("estimate.requests_added", :count => num_added)
    redirect_to admin_estimate_path(@estimate)
  end

  def send_estimate_requests
    num_sent = 0
    @estimate.estimate_requests.with_state(:pending).each do |estimate_request|
      if estimate_request.send_request
        UserMailer.estimate_request(estimate_request).deliver
        num_sent = num_sent + 1
      end
    end
    flash[:success] = t("estimate.successfully_sent_requests", :count => num_sent)
    redirect_to admin_estimate_path(@estimate)
  end


  def edit
    @estimate_type = @estimate.type
  end

  def update
    @estimate_type = @estimate.type
    if @estimate.update_attributes estimate_parameters
      flash[:success] = t("helpers.successfully_updated")
      redirect_to admin_estimate_path(@estimate)
    else
      render :edit
    end
  end

  def update_email
    if @estimate.update_attributes estimate_mail_parameters
      @estimate.estimate_requests.with_state(:pending).each do |estimate_request|
        estimate_request.copy_email_from_estimate
      end
      flash[:success] = t("helpers.successfully_updated")
      redirect_to admin_estimate_path(@estimate)
    else
      render :edit
    end
  end

  def update_comments
    if @estimate.update_attributes estimate_comments_parameters
      flash[:success] = t("helpers.successfully_updated")
      redirect_to admin_estimate_path(@estimate)
    else
      render :edit
    end
  end

  def destroy
    if @estimate.destroy
      flash[:success] = t("helpers.successfully_deleted")
    end
    redirect_to admin_estimates_path
  end

  def change_state
    unless params[:state].blank?
      @estimate.state = params[:state]
      @estimate.save
    end
    redirect_to admin_estimates_path
  end

  private

    def find_model
      @estimate = Estimate.find params[:id]
    end

    def estimate_parameters
      params.require(:estimate).permit(:state, :number_of_items, :origin_port_id, :destination_port_id, :customer_id, :origin_address, :origin_city, :origin_zip, :origin_province, :origin_country_id, :destination_address, :destination_city, :destination_zip, :destination_province, :destination_country_id, :description, :shipment_type, :shipments_per_month, :equipment_20_dv, :equipment_20_ot, :equipment_20_rf, :equipment_20_fr, :equipment_40_dv, :equipment_40_hc, :equipment_40_ot, :equipment_40_rf, :equipment_40_fr, :temperature, :imo, :imo_class, :imo_un, :oog, :stowage_factor, :loading_laytime, :unloading_laytime, :charterer, :estimate_items_attributes => [:id, :type, :_destroy, :quant_type, :size_type, :number_of_items, :description, :description2, :length, :width, :height, :diameter, :weight])
    end

    def estimate_mail_parameters
      params.require(:estimate).permit(:email_subject, :email_content, :email_additional_content)
    end

    def estimate_comments_parameters
      params.require(:estimate).permit(:comments)
    end
end