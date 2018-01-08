require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it { should validate_presence_of(:quantity) }
  it { should validate_numericality_of(:quantity) }

  it { should belong_to(:book) }
  it { should belong_to(:order) }

  context '#price' do 
    let(:order_item) { create :order_item, quantity: 2 }

    it 'returns counted price' do 
      order_item.stub_chain(:book, :price).and_return(9.0)
      expect(order_item.price).to eq(18.0)      
    end
  end
end