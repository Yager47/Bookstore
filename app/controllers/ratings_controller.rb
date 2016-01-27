class RatingsController < ApplicationController
  before_action :set_book
  before_action :authenticate_user!

  def new
  	@rating = @book.ratings.new
  end

  def create
  	@rating = @book.ratings.create(rating_params)
  	@rating.user = current_user

    if @rating.save
      redirect_to @book, notice: 'Review was successfully created.'
    else
      render :new
    end  
  end

  private
  	def set_book
  		@book = Book.find(params[:book_id])
  	end

  	def rating_params
  		params.require(:rating).permit(:value, :review)
  	end
end
