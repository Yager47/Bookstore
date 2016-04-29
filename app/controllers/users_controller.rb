class UsersController < ApplicationController
  before_action :authenticate_user!

  def update
    current_user.update(user_params)
    if current_user.save
      redirect_to settings_url, notice: 'User changes were cuccessfully updated.'
    else
      redirect_to settings_url, alert: 'All your changes must be valid.'
    end
  end

  private
    def user_params
      params.require(:user).permit(
        billing_address_attributes: [:first_name, :last_name, :city, :street, :country, :zipcode, :phone], 
        shipping_address_attributes: [:first_name, :last_name, :city, :street, :country, :zipcode, :phone])
    end
end
