class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end


  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :name

      devise_parameter_sanitizer.for(:account_update) do |u|
        u.permit(:name, :email, :password,
          :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar,
          :remote_avatar_url)
      end
    end
end
