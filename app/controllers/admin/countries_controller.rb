class Admin::CountriesController < Admin::AdminController

  before_filter :find_model, :only => %w( edit update destroy)

  
  def index
    @countries = Country.all
  end

  def new
    @country = Country.new
  end

  def create
    @country = Country.new country_parameters
    if @country.save
      flash[:success] = t("helpers.successfully_created")
      redirect_to admin_countries_path
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @country.update_attributes country_parameters
      flash[:success] = t("helpers.successfully_updated")
      redirect_to admin_countries_path
    else
      render :edit
    end
  end

  def destroy
    if @country.destroy
      flash[:success] = t("helpers.successfully_deleted")
    end
    redirect_to admin_countries_path
  end


  private

    def find_model
      @country = Country.find params[:id]
    end

    def country_parameters
      params.require(:country).permit(:code, :name, :comments)
    end

end