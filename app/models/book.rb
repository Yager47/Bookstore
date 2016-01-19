class Book < ActiveRecord::Base
	belongs_to :author
	belongs_to :category
	has_many   :ratings
	has_many   :order_items

	validates :price, presence: true
	validates :title, presence: true, length: { in: 1..80 }
	validates :books_in_stock, presence: true, 
						numericality: { only_integer: true, greater_than_or_equal_to: 0 }

	def self.best_sellers
		self.all.order(books_in_stock: :desc)
	end
end
