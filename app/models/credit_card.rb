class CreditCard < ActiveRecord::Base
  belongs_to :user
  belongs_to :order

  validates :number, presence: true
  validates :cvv, presence: true
  validates :expiration_date, presence: true
end
