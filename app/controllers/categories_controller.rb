class CategoriesController < ApplicationController
  before_action :set_category

  def show
    @categories = Category.all
  	@books = @category.books.page(params[:page]).per(6)
  end

  private
  	def set_category
  		@category = Category.find(params[:id])
  	end
end
