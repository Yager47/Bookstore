require 'rails_helper'

describe BooksController, type: :controller do 

  describe 'GET #index' do 
    let(:book) { create :book }
    let(:category) { create :category }

    before do
      get :index
    end

    it 'assigns @books' do 
      assigns(:books).should eq([book])
    end

    it 'assigns @categories' do 
      assigns(:categories).should eq([category])
    end

    it 'renders the #index view' do 
      response.should render_template :index
    end
  end

  describe 'GET #best_sellers' do
    let(:book) { create :book }

    before do 
      get :best_sellers
    end

    it 'assigns @books' do 
      assigns(:books).should eq([book])
    end

    it 'renders the #best_sellers view' do
      response.should render_template :best_sellers
    end
  end

  describe 'GET #show' do 
    let(:book) { create :book }
    let(:user) { create :user }
    let(:rating) { create :rating, book_id: book.id }

    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      get :show, id: book
    end

    it 'assigns requested book to @book' do
      assigns(:book).should eq(book)
    end

    it 'assigns @ratings' do
      assigns(:ratings).should eq([rating])
    end

    it 'sets :order_item_book param to session' do
      expect(session[:order_item_book]).to eq(book.id)
    end

    it 'renders the #show view' do
      response.should render_template :show
    end
  end
end