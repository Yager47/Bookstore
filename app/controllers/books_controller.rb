class BooksController < ApplicationController
  def index
    @books = Book.all.page(params[:page]).per(6)
    @categories = Category.all
  end

  def best_sellers
    @books = Book.best_sellers.page(params[:page]).per(1)
  end

  def show
    if user_signed_in?
      @order_item = current_order.order_items.new
    end
    @book = Book.find(params[:id])
    @ratings = @book.ratings
    session[:order_item_book] = @book.id
  end
end
