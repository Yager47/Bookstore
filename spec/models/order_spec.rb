require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { build :order }

  it { should belong_to(:user) }

  it { should have_many(:order_items).dependent(:destroy) }

  it { should have_one(:billing_address).dependent(:destroy) }
  it { should have_one(:shipping_address).dependent(:destroy) }
  it { should have_one(:credit_card).dependent(:destroy) }

  it { should accept_nested_attributes_for(:billing_address) }
  it { should accept_nested_attributes_for(:shipping_address) }
  it { should accept_nested_attributes_for(:credit_card) }

  context '#aasm_state' do
    it 'do transitions right' do
      expect(order).to have_state(:in_progress)

      expect(order).to transition_from(:in_progress).to(:completed).on_event(:complete)
      expect(order).to have_state(:completed)

      expect(order).to transition_from(:completed).to(:shipped).on_event(:ship)
      expect(order).to have_state(:shipped)
    end
  end

  context '#sub_total' do
    before do 
      order.order_items = create_list(:order_item, 4)
      order.order_items.each { |item| item.stub(:price).and_return(5.5) }
    end

    it 'sums order_items without delivery' do 
      expect(order.sub_total).to eq(22.0)
    end
  end

  context '#total_price' do
    before do 
      order.stub(:sub_total).and_return(10.0)
      order.stub(:delivery).and_return(5.5)
    end

    it 'counts full order price' do 
      expect(order.total_price).to eq(15.5)
    end
  end
end