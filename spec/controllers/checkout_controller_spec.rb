require 'rails_helper'

describe CheckoutController, type: :controller do 

  describe 'GET #show' do 

    let(:user) { create :user }    
    let(:order) { create :order, user_id: user.id }
    let(:book) { create :book }

    before do 
      sign_in user
      controller.stub(:current_order).and_return(order)
      create :order_item, order_id: order.id, book_id: book.id
    end 

    context 'when :address' do 
      # let(:country) { create :country }

      before do
        create :country
        get :show, id: :address
      end

      it 'renders :address template' do 
        response.should render_template :address
      end
      
      it 'builds billing address if order don\'t has it' do 
        expect(order.billing_address).not_to be_nil
      end

      it 'builds shipping address if order don\'t has it' do 
        expect(order.shipping_address).not_to be_nil
      end

      it 'assigns @countries' do 
        assigns(:countries).should eq([Array.new(2, Country.last.name)])
      end
      
      context 'when order items are empty' do 
        before do
          order.stub_chain(:order_items, :empty?).and_return(true)
          get :show, id: :address
        end

        it 'redirects to cart' do 
          response.should redirect_to cart_url
        end
      end
    end

    context 'when :delivery' do 
      before do 
        get :show, id: :delivery
      end 

      it 'renders :delivery template' do 
        response.should render_template :delivery
      end
    end

    context 'when :payment' do 
      before do
        get :show, id: :payment
      end

      it 'renders :payment template' do 
        response.should render_template :payment
      end

      it 'builds credit card if order don\'t has it' do 
        expect(order.credit_card).not_to be_nil
      end
    end

    context 'when :confirm' do 
      before do 
        get :show, id: :confirm
      end

      it 'renders :confirm template' do 
        response.should render_template :confirm
      end
    end

    context 'when :complete' do

      before do 
        get :show, id: :complete
      end

      it 'marks order as completed' do 
        expect(order.aasm_state).to eq('completed') 
      end

      it 'sets completed date' do 
        expect(order.completed_date).not_to be_nil
      end
      
    end
  end
end