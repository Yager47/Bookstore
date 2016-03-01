class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @order_items = current_order.order_items
  end

  def clear
    current_order.order_items.each(&:destroy)
    redirect_to cart_url
  end
end
