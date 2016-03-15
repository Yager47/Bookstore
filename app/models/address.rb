class Address < ActiveRecord::Base
  belongs_to :order
  belongs_to :user

  validates :first_name, :last_name, presence: true, length: { in: 1..30 }
  validates :city, :street, presence: true, length: { in: 1..80 }
  validates :country, presence: true, length: { in 1..50 }
  validates :phone, presence: true, format: { with: /\A[0-9]{12}\z/ }
  validates :zipcode, presence: true, format: { with: /\A\d{5}-\d{4}|\A\d{5}\z/ }
end
