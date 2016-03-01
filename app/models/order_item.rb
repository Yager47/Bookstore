class OrderItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :order

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def price
    self.book.price * quantity
  end
end
