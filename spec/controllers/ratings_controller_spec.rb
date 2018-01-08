require 'rails_helper'

describe RatingsController, type: :controller do 
  
  let(:user) { create :user }
  let(:book) { create :book }

  before do 
    Book.stub(:find).and_return(book)
    sign_in user
  end

  describe 'GET #new' do 
    before do
      get :new, book_id: book.id
    end   

    it 'assigns new rating to @rating' do 
      assigns(:rating).should be_a_new(Rating)
    end

    it 'renders #new template' do 
      response.should render_template :new
    end
  end

  describe 'POST #create' do 
    
    context 'with valid attributes' do 
      let(:rating_attributes) { attributes_for :rating }
      
      it 'creates a new rating' do 
        expect{ post :create, rating: rating_attributes, book_id: book.id }.to change(Rating, :count).by(1)
      end

      it 'redirects to the book' do 
        post :create, rating: rating_attributes, book_id: book.id
        response.should redirect_to book
      end

      it 'sets rating user_id to current_user' do 
        post :create, rating: rating_attributes, book_id: book.id
        expect(Rating.last.user_id).to eq(user.id)
      end
    end

    context 'with invalid attributes' do 
      let(:invalid_rating_attributes) { attributes_for :rating }

      before do 
        invalid_rating_attributes[:value] = 11
      end

      it 'does not save the new rating' do 
        expect{ post :create, rating: invalid_rating_attributes, book_id: book.id }.not_to change(Rating, :count)
      end

      it 're-renders #new template' do 
        post :create, rating: invalid_rating_attributes, book_id: book.id
        response.should render_template :new
      end
    end
  end
end