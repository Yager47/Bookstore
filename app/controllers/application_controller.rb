class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order

  def current_order
    current_user.orders.find_by(aasm_state: "in_progress") || current_user.orders.new
  end
end
