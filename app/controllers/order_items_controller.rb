class OrderItemsController < ApplicationController
  before_action :set_order
  before_action :set_order_items, only: [:update, :destroy]
  
  load_and_authorize_resource

  def create
    if @order_item = @order.order_items.find_by(book_id: session[:order_item_book])
      @order_item.update(order_item_params)
    else
      @order_item = @order.order_items.new(order_item_params)
      @order_item.book_id = session[:order_item_book]
    end
    @order.save
    redirect_to cart_url
  end

  def update
    @order_item.update(order_item_params)
    @order.save
    redirect_to cart_url
  end

  def destroy
    @order_item.destroy
    redirect_to cart_url
  end

  private
    def set_order
      @order = current_order
    end

    def set_order_items
      @order_item = @order.order_items.find(params[:id])
    end

    def order_item_params
      params.require(:order_item).permit(:quantity)
    end
end
