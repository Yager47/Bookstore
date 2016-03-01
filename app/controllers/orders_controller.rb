class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @in_progress_order = current_order
    @completed_orders = current_user.orders.where(aasm_state: 'completed')
    @shipped_orders = current_user.orders.where(aasm_state: 'shipped')
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    current_order.update(order_params)
    redirect_to next_checkout_url
  end

  def destroy
    current_order.destroy
    redirect_to root_url
  end

  private
    def next_checkout_url
      case params[:current_path]
      when checkout_address_path  then checkout_delivery_url
      when checkout_delivery_path then checkout_payment_url 
      when checkout_payment_path  then checkout_confirm_url
      when checkout_confirm_path  then checkout_complete_url
      else root_url
      end
    end

    def order_params
      params.require(:order).permit(:total_price, :user_id, :credit_card_id, :delivery, 
        billing_address_attributes: [:first_name, :last_name, :city, :street, :country, :zipcode, :phone], 
        shipping_address_attributes: [:first_name, :last_name, :city, :street, :country, :zipcode, :phone])
    end
end
