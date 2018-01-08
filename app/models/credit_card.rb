class CreditCard < ActiveRecord::Base
  belongs_to :user
  belongs_to :order

  validates :number, presence: true, format: { with: /\A[0-9]{16}\z/ }
  validates :cvv, presence: true, format: { with: /\A[0-9]{3}\z/ }
  validates :expiration_date, presence: true, inclusion: { in: Date.today..20.years.from_now.to_date }
end
