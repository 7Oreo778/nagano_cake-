class Public::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
   root_path
  end

  before_action :customer_state, only: [:create]

  protected

  def customer_state
    @customer = Customer.find_by(email: params[:customer][:email])
    return if !@customer
    if @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted

       redirect_to new_customer_registration_path


    end
  end

end
