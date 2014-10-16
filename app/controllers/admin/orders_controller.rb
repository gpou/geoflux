class Admin::OrdersController < Admin::AdminController

  before_filter :find_model, :except => %w( index save_estimate )

  def index
    @orders = Order.all
  end

  def save_estimate
    estimate_request = EstimateRequest.find(params[:estimate_request_id])
    @order = Order.new
    @order.save_estimate(estimate_request)
    redirect_to admin_orders_path
  end

  def change_state
    unless params[:state].blank?
      @order.state = params[:state]
      @order.save
    end
    redirect_to admin_orders_path
  end

  def update
    if @order.update_attributes order_parameters
      flash[:success] = t("helpers.successfully_updated")
      redirect_to admin_order_path(@order)
    else
      render :edit
    end
  end

  def update_comments
    if @order.update_attributes order_comments_parameters
      flash[:success] = t("helpers.successfully_updated")
      redirect_to admin_order_path(@order)
    else
      render :edit
    end
  end

  def destroy
    if @order.destroy
      flash[:success] = t("helpers.successfully_deleted")
    end
    redirect_to admin_orders_path
  end

  private

    def find_model
      @order = Order.find params[:id]
    end

    def order_parameters
      params.require(:order).permit(:date, :reference, :price, :state)
    end

    def order_comments_parameters
      params.require(:order).permit(:comments)
    end

end