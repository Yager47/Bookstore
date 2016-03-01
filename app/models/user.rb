class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :ratings
  has_many :orders, dependent: :destroy
  has_many :credit_cards
  has_one :billing_address, class_name: 'Address', dependent: :destroy
  has_one :shipping_address, class_name: 'Address', dependent: :destroy

  accepts_nested_attributes_for :billing_address, :shipping_address

  validates :first_name, :last_name, :email, presence: true, length: { in: 1..80 }

  def admin?
  	admin ? true : false
  end

  def name
  	"#{self.first_name} #{self.last_name}"
  end
end
