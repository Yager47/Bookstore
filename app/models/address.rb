class Address < ActiveRecord::Base
  belongs_to :order

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :city, presence: true
  validates :street, presence: true
  validates :country, presence: true
  validates :phone, presence: true
  validates :zipcode, presence: true
end
