class AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_order

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def set_user
      @user = current_user
    end

    def set_order
      @order = current_order
    end
end
