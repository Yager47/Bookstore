class Rating < ActiveRecord::Base
	belongs_to :user
	belongs_to :book

	# ratyrate_rateable 'value'

	validates :review, presence: true
	validates :value,  presence: true, 
            numericality: { 
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 10
             }
end
