class ApplicationController < ActionController::Base
rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_url, alert: exception.message
  end

   before_action :configure_permitted_parameters, if: :devise_controller?
   before_action :authenticate_user!

  protected

  def configure_permitted_parameters
  # Permit the `subscribe_newsletter` parameter along with the other
  # sign up parameters.
  devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :date_of_birth, :email , :password , :gender , :age, avatar: [] ])
  devise_parameter_sanitizer.permit(:account_update , keys: [:first_name, :last_name, :date_of_birth, :email , :password , :gender, :age, avatar: [] ])
  end
end
