class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  after_action :remember_action
  after_action :remember_controller

  def change_locale
    language = params[:locale].to_sym
    if I18n.available_locales.include?(language)
      I18n.locale = language
      session[:current_locale] = language
    end 
    redirect_to request.referer || root_url
  end

  private
    def set_locale
      I18n.locale = session[:current_locale] if session[:current_locale]
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :remember_me) }
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
    end

    def current_order
      if user_signed_in?
        current_user.orders.find_by(aasm_state: "in_progress") || current_user.orders.new
      end
    end

    def remember_controller
      session[:previous_controller] = params[:controller]
    end

    def remember_action
      session[:previous_action] = params[:action]
    end 
end
