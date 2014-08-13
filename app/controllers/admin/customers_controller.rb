class Admin::CustomersController < Admin::AdminController

  
  def index
    @customers = Customer.all
  end

end