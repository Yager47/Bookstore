class CheckoutController < ApplicationController
  before_action :set_order

  def address
  end

  def delivery
  end

  def payment
  end

  def confirm
  end

  def complete
  end
      
  private
    def set_order
      if current_order.order_items.empty?
        redirect_to cart_url
      else
        @order = current_order
      end
    end
end