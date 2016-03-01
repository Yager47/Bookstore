class SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show # !
    @user.build_billing_address unless @user.billing_address
    @user.build_shipping_address unless @user.shipping_address
    @countries = Country.all.map { |country| Array.new(2, country.name) }.sort
  end

  private 
    def set_user
      @user = current_user
    end
end
