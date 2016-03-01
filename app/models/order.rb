class Order < ActiveRecord::Base
  include AASM

  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_one :billing_address, class_name: 'Address', dependent: :destroy
  has_one :shipping_address, class_name: 'Address', dependent: :destroy
  has_one :credit_card, dependent: :destroy

  accepts_nested_attributes_for :billing_address, :shipping_address, :credit_card

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

  def sub_total
    self.order_items.inject(0) { |acc, item| acc += item.price }
  end

  def total_price
    self.delivery + sub_total
  end
end
