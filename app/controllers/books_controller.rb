class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :admin_check, except: [:index, :show, :best_sellers]
  before_action :authenticate_user!, except: [:index, :show, :best_sellers]

  def index
    @books = Book.all.page(params[:page]).per(6)
    @categories = Category.all
  end

  def new
    @book = Book.new
  end

  def best_sellers
    @books = Book.best_sellers.page(params[:page]).per(1)
  end

  def show
    @ratings = @book.ratings
    @order_item = current_order.order_items.new
    session[:order_item_book] = @book.id
  end

  def edit
  end

  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def admin_check
      redirect_to root_path unless user_signed_in? && current_user.admin?
    end 

    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :description, :price, :books_in_stock)
    end
end
