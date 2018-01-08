require 'date'

class CheckoutController < ApplicationController
  include Wicked::Wizard
  before_action :set_order

  steps :address, :delivery, :payment, :confirm, :complete

  def show
    case step
    when :address
      if @order.order_items.empty?
        redirect_to cart_url, alert: 'Cart can not be empty. Add items to your cart before continue.'
      else
        @order.build_billing_address unless @order.billing_address
        @order.build_shipping_address unless @order.shipping_address
        @countries = Country.all.map { |country| Array.new(2, country.name) }.sort
      end

    when :payment
      @order.build_credit_card unless @order.credit_card

    when :complete
      @order.complete
      @order.completed_date = DateTime.now
      @order.order_items.each do |item| 
        item.quantity.times { item.book.sold! } 
      end
      @order.save
    end

    step == :complete ? redirect_to(@order) : render_wizard 
  end

  def update
    @order.update_attributes(order_params)
    render_wizard @order
  end
      
  private
    def set_order
      if current_order.order_items.empty?
        redirect_to cart_url
      else
        @order = current_order
      end
    end

    def order_params
      params.require(:order).permit(:total_price, :user_id, :delivery, 
        billing_address_attributes: [:first_name, :last_name, :city, :street, :country, :zipcode, :phone], 
        shipping_address_attributes: [:first_name, :last_name, :city, :street, :country, :zipcode, :phone],
        credit_card_attributes: [:number, :cvv, :expiration_date])
    end
end