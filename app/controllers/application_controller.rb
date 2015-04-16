class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [
      :first_name,
      :last_name,
      :street_address,
      :street_address_2,
      :city,
      :state,
      :zip_code,
      :phone
    ]
  end

  def not_found
    raise ActionController::RoutingError.new("Not Found")
  end

  def authorize_user!
    unless current_user.admin? || current_user == User.find(params[:id])
      not_found
    end
  end

  def authorize_admin!
    unless current_user.admin?
      not_found
    end
  end
end
