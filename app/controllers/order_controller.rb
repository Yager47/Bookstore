class OrderController < ApplicationController
  before_action :set_order, only: [:update, :destroy]

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
  end

  def update
    @order.update(order_params)
    redirect_to next_checkout_url
  end

  def destroy
    @order.destroy
    redirect_to root_url
  end

  private
    def next_checkout_url
      case params[:current_path]
      when checkout_address_path  then checkout_delivery_url
      when checkout_delivery_path then checkout_payment_url 
      when checkout_payment_path  then checkout_confirm_url
      else root_url
      end
    end

    def set_order
      @order = current_order
    end

    def order_params
      params.require(:order).permit(:total_price, :user_id, :delivery, 
        billing_address_attributes: [:first_name, :last_name, :city, :street, :country, :zipcode, :phone], 
        shipping_address_attributes: [:first_name, :last_name, :city, :street, :country, :zipcode, :phone])
    end
end
