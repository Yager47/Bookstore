class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order
  after_action :remember_action
  after_action :remember_controller

  def current_order
    current_user.orders.find_by(aasm_state: "in_progress") || current_user.orders.new
  end

  private
    def remember_controller
      session[:previous_controller] = params[:controller]
    end

    def remember_action
      session[:previous_action] = params[:action]
    end 
end
