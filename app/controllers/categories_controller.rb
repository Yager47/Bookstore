class CategoriesController < ApplicationController
<<<<<<< HEAD

  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @books = @category.books.page(params[:page]).per(6)
  end
=======
  before_action :set_category

  def show
    @categories = Category.all
    @books = @category.books.page(params[:page]).per(6)
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end
>>>>>>> fde6d69f324d2e68376e4aa63ad278214ec3cdf2
end
