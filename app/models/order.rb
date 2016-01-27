class Order < ActiveRecord::Base
	include AASM

	belongs_to :user
	has_many :order_items
	has_one :billing_address, class_name: 'Address'#, foreign_key: 'billing_address_id'
	has_one :shipping_address, class_name: 'Address'#, foreign_key: 'shipping_address_id'

	accepts_nested_attributes_for :billing_address, :shipping_address

	# validates :total_price, presence: true
	# validates :completed_date, presence: true

	aasm :column => :aasm_state do
		state :in_progress, :initial => true
		state :completed
		state :shipped

		event :complete do 
			transitions :from => :in_progress, :to => :completed
		end

		event :ship do 
			transitions :from => :completed, :to => :shipped
		end
	end

	def total_price
		self.order_items.inject(0) { |acc, item| acc += item.price }
	end
end
