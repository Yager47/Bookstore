class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def update
    # @user.billing_address, @user.shipping_address = Address.all.sort_by(&:updated_at).last(2)
    @user.update(user_params)
    if @user.save
      redirect_to settings_url, notice: 'User changes were cuccessfully updated.'
    else
      redirect_to settings_url, alert: 'All your changes must be valid.'
    end
  end

  private
    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(
        billing_address_attributes: [:first_name, :last_name, :city, :street, :country, :zipcode, :phone], 
        shipping_address_attributes: [:first_name, :last_name, :city, :street, :country, :zipcode, :phone])
    end
end
