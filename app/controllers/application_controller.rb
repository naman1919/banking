class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :permitted_parameters, if: :devise_controller?

  def permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name,:occupation, :father_name, :mother_name, :father_occupation, :mother_occupation, :mobile_no, :social_security_no, :pan ,:document, :user_photo, :bank_id, local_address_attributes: [:house_no, :street_no, :area, :city, :state, :country, :pin, :address_proof], permanent_address_attributes: [:house_no, :street_no, :area, :city, :state, :country, :pin, :address_proof]])
  end
end
