require 'rails_helper'

describe CategoriesController, type: :controller do 
  
  describe 'GET #show' do 
    let(:category) { create :category }
    let(:book) { create :book, category_id: category.id }

    before do 
      get :show, id: category
    end
    
    it 'assigns @categories' do 
      assigns(:categories).should eq([category])
    end

    it 'assigns requested category to @category' do 
      assigns(:category).should eq(category)
    end

    it 'assigns @books' do
      assigns(:books).should eq([book])
    end
  end
end