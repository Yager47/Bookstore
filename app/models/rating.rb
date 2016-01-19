class Rating < ActiveRecord::Base
	belongs_to :user
	belongs_to :book

	# ratyrate_rateable 'value'

	validates :review, presence: true
	validates :value,  presence: true, numericality: { in: 1..10 }
end
