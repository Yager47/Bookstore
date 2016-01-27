class Address < ActiveRecord::Base
  belongs_to :order

  validates :city, presence: true
  validates :street, presence: true
  validates :phone, presence: true
  validates :zipcode, presence: true
end
