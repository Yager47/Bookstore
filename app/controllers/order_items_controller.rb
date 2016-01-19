class OrderItemsController < ApplicationController
	before_action :set_order
	before_action :set_order_item, only: [:update, :destroy]

  def create
  	@order_item = @order.order_items.new(order_item_params)
  	@order.save
	end

  def update
  	@order_item.update(order_item_params)
  	@order.save
  end

  def destroy
  	@order_item.destroy
  end

  private
  	def set_order
  		@order = current_order
  	end

  	def set_order_item
  		@order_item = @order.order_items.find(params[:id])
  	end

  	def order_item_params
  		params.require(:order_item).permit(:quantity, :book_id)
  	end
end
