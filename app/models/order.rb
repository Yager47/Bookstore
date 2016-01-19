class Order < ActiveRecord::Base
	include AASM

	belongs_to :user
	has_many   :order_items

	validates :total_price, presence: true
	validates :completed_date, presence: true

	aasm do
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
end
