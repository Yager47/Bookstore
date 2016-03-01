require 'date'

class CheckoutController < ApplicationController
  before_action :set_order
  # before_action :sequence_check, except: [:address]

  def address
    if @order.order_items.empty?
      redirect_to cart_url, alert: 'Cart can not be empty. Add items to your cart before continue.'
    else
      @order.build_billing_address unless @order.billing_address
      @order.build_shipping_address unless @order.shipping_address
      @countries = Country.all.map { |country| Array.new(2, country.name) }.sort
    end
  end

  def delivery
  end

  def payment
  end

  def confirm
  end

  def complete
    @order.complete
    @order.completed_date = DateTime.now
    @order.save
    redirect_to @order
  end
      
  private
    def sequence_check # !
      unless session[:previous_action] == previous_action || session[:previous_action] == params[:action]
        redirect_to checkout_address_path, alert: 'You must complete all previous checkout steps before continue.'
      end 
    end

    def previous_action
      case params[:action]
      when 'delivery' then 'address'
      when 'payment'  then 'delivery'
      when 'confirm'  then 'payment'
      else params[:action]
      end       
    end

    def set_order
      if current_order.order_items.empty?
        redirect_to cart_url
      else
        @order = current_order
      end
    end
end