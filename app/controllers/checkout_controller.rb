class CheckoutController < ApplicationController
  before_action :set_order
  before_action :sequence_check, except: [:address]
  after_action :remember_action, except: [:complete]

  def address
    if @order.order_items.empty?
      redirect_to cart_url, alert: 'Cart can not be empty. Add items to your cart before continue.'
    end
    @countries = Country.all.map { |country| [country.name, country.name] }.sort
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
    def sequence_check
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

    def remember_action
      session[:previous_action] = params[:action]
    end 

    def set_order
      if current_order.order_items.empty?
        redirect_to cart_url
      else
        @order = current_order
      end
    end
end