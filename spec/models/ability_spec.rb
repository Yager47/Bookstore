require 'rails_helper'
require 'cancan/matchers'

describe Ability, type: :model do 

  describe 'not signed in user abilities' do 
    let(:ability) { Ability.new(user) }
    let(:user) { nil }

    context 'for books' do 
      let(:book) { create :book }
      it { expect(ability).to be_able_to(:read, book) }
    end

    context 'for categories' do 
      let(:category) { create :category }
      it { expect(ability).to be_able_to(:read, category) }
    end

    context 'for ratings' do
      let(:rating) { create :rating }
      it { expect(ability).not_to be_able_to(:create, rating) }
    end

    context 'for orders' do
      let(:order) { create :order }
      it { expect(ability).not_to be_able_to(:create, order) }
      it { expect(ability).not_to be_able_to(:read, order) }
      it { expect(ability).not_to be_able_to(:update, order) }
    end    

    context 'for order_items' do
      let(:order_item) { create :order_item }
      it { expect(ability).not_to be_able_to(:create, order_item) }
      it { expect(ability).not_to be_able_to(:read, order_item) }
      it { expect(ability).not_to be_able_to(:update, order_item) }
    end

    context 'for users' do 
      it { expect(ability).not_to be_able_to(:manage, user) }
    end
  end

  describe 'signed in user abilities' do 
    let(:ability) { Ability.new(user) }
    let(:user) { create :user }

    context 'if user is admin' do 
      let(:ability) { Ability.new(admin) }
      let(:admin) { create :user, admin: true }
      it { expect(ability).to be_able_to(:manage, :all) }
    end

    context 'for ratings' do
      let(:rating) { create :rating }
      it { expect(ability).to be_able_to(:create, rating) }
    end

    context 'for orders' do
      let(:order) { create :order, user_id: user.id }
      let(:completed_order) { create :order, user_id: user.id, aasm_state: 'completed' }
      let(:other_order) { create :order }

      it { expect(ability).to be_able_to(:create, order) }
      it { expect(ability).to be_able_to(:read, order) }
      it { expect(ability).to be_able_to(:update, order) }

      it { expect(ability).not_to be_able_to(:update, completed_order) }      

      it { expect(ability).not_to be_able_to(:create, other_order) }
      it { expect(ability).not_to be_able_to(:read, other_order) }
      it { expect(ability).not_to be_able_to(:update, other_order) }      
    end    

    context 'for order_items' do
      let(:order_item) { create :order_item }
      let(:other_order_item) { create :order_item }

      before do 
        order_item.stub_chain(:book, :in_stock?).and_return(true)
        order_item.stub_chain(:order, :aasm_state).and_return('in_progress')

        other_order_item.stub_chain(:book, :in_stock?).and_return(false)
        other_order_item.stub_chain(:order, :aasm_state).and_return('completed')
      end

      it { expect(ability).to be_able_to(:create, order_item) }
      it { expect(ability).to be_able_to(:update, order_item) }
      it { expect(ability).to be_able_to(:delete, order_item) }

      it { expect(ability).not_to be_able_to(:create, other_order_item) }
      it { expect(ability).not_to be_able_to(:update, other_order_item) }
      it { expect(ability).not_to be_able_to(:delete, other_order_item) }
    end

    context 'for users' do 
      it { expect(ability).to be_able_to(:manage, user) }
    end
  end
end