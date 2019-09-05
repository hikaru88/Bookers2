class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :set_current_user
  #
  # def set_current_user
  #   @current_user = User.find_by(id: session[:user_id])
  # end

  def after_sign_in_path_for(resource)
    user_home_path(current_user[:id])
  end

  protected

  def configure_permitted_parameters
    added_attrs = [ :name, :email, :password, :password_confirmation ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end

end
