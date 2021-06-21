class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:fullname, :username, :email, :password, :password_confirmation, :photo, :background_image)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:fullname, :username, :email, :password, :password_confirmation, :photo, :background_image,
               :current_password)
    end
  end
end
