require 'rails_helper'

describe CartsController, type: :controller do 
  
  let(:user) { create :user }
  let(:order) { create :order }
  
  before do 
    sign_in user
    controller.stub(:current_order).and_return(order)
  end
  
  describe 'GET #show' do 
    it 'assigns @order_items' do
      order_item = create :order_item, order: order 
      get :show
      assigns(:order_items).should eq([order_item])
    end
  end

  describe 'DELETE #clear' do 
    it 'deletes order_items' do 
      create :order_item, order: order 
      expect{ delete :clear }.to change(OrderItem, :count).by(-1)
    end

    it 'redirects to cart#show' do 
      delete :clear
      response.should redirect_to cart_url
    end
  end
end