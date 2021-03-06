class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :category

  has_many :ratings
  has_many :order_items
  
  validates :title, presence: true, length: { in: 1..80 }
  
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  
  validates :books_in_stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  
  validates :sales, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def self.best_sellers
    all.order(sales: :desc)
  end

  def sold!
    if books_in_stock > 0
      sales += 1
      books_in_stock -= 1
      save
    end
  end

  def in_stock?
    books_in_stock > 0
  end
end
