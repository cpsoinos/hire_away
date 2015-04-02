class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :password,
      :password_confirmation, :street_address,
      :street_address_2, :city, :state, :zip_code, :phone
      )
  end

  def account_update_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :password,
      :password_confirmation, :current_password,
      :street_address, :street_address_2,
      :city, :state, :zip_code, :phone
      )
  end
end
