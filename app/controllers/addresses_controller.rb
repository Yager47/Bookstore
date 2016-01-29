class AddressesController < ApplicationController
  before_action :set_order

  def new
  end

  def create
  end

  def update
  end

  def destroy
  end

  private
    def set_order
      @order = current_order
    end
end
