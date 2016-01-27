class AddressesController < ApplicationController
  before_action :set_order, only: [:new, :create]
  before_action :set_billing_address, only: [:update, :destroy]
  before_action :set_shipping_address, only: [:update, :destroy]

  def new
    @billing_address = @order.build_billing_address
    @shipping_address = @order.build_shipping_address
  end

  def create
    @billing_address = @order.build_billing_address(billing_address_params)
    @shipping_address = @order.build_shipping_address(shipping_address_params)
    if @billing_address.save && @shipping_address.save
      redirect_to checkout_address_url, notice: 'Billing and shipping addresses were successfully added to order.'
    else
      redirect_to checkout_address_url, notice: 'Wrong billing or shipping address format.'
    end
  end

  def update
    @billing_address.update(billing_address_params)
    if @billing_address.save
      redirect_to checkout_address_url, notice: 'Billing address was successfully updated.'
    else
      redirect_to checkout_address_url, notice: 'Wrong billing address format.'
    end
  end

  def destroy
    @billing_address.destroy
  end

  private
    def set_order
      @order = current_order
    end

    def set_billing_address
      @billing_address = @order.billing_address.find(params[:id])
    end

    def set_shipping_address
      @shipping_address = @order.shipping_address.find(params[:id])
    end    

    def billing_address_params
      params.require(:address).permit(:city, :street, :zipcode, :phone)
    end

    def shipping_address_params
      params.require(:address).permit(:city, :street, :zipcode, :phone)
    end
end
