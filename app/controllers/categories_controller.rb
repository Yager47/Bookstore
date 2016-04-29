class CategoriesController < ApplicationController

  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @books = @category.books.page(params[:page]).per(6)
  end
end
