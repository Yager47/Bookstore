require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { create :book }

  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title) }

  it { should validate_presence_of(:price) }
  it { should validate_numericality_of(:price) }
  
  it { should validate_presence_of(:books_in_stock) }
  it { should validate_numericality_of(:books_in_stock) }

  it { should validate_presence_of(:sales) }
  it { should validate_numericality_of(:sales) }

  it { should belong_to(:author) }
  it { should belong_to(:category) }

  it { should have_many(:ratings) }
  it { should have_many(:order_items) }

  context '.best_sellers' do
    before do
      # FactoryGirl.create_list(:book, 10)
      10.times { create :book }
    end

    let(:books) { Book.all }
    let(:best_sellers) { Book.best_sellers }

    it 'returns all existing books' do 
      expect(best_sellers).to match_array(books) 
    end 

    it 'returns books in right order' do 
      best_seller = Book.all.max_by(&:sales)
      worst_seller = Book.all.min_by(&:sales)
      
      expect(best_seller).to eq(best_sellers.first)
      expect(worst_seller).to eq(best_sellers.last)
    end
  end

  context '#sold!' do 
    before :each do 
      book.books_in_stock = 2
      book.sales = 0
    end

    it 'decrements books_in_stock' do 
      expect{ book.sold! }.to change{ book.books_in_stock }.from(2).to(1) 
    end

    it 'increments sales' do
      expect{ book.sold! }.to change{ book.sales }.from(0).to(1)
    end

    it 'changes nothing if book is not in stock' do 
      book.books_in_stock = 0
      expect{ book.sold! }.not_to change{ book.books_in_stock }
      expect{ book.sold! }.not_to change{ book.sales }
    end
  end

  context '#in_stock?' do
    it 'returns true if books_in_stock > 0' do 
      book.books_in_stock = 1
      expect(book.in_stock?).to be_truthy
    end

    it 'returns false if books_in_stock == 0' do 
      book.books_in_stock = 0
      expect(book.in_stock?).to be_falsey
    end
  end
end
