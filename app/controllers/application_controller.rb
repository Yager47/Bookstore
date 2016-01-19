class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order

  def current_order
  	order = Order.last
  	(order && order.in_progress?) ? order : Order.new
  end
end
