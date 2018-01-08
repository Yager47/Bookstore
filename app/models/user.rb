class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :ratings
  has_many :orders, dependent: :destroy
  has_many :credit_cards

  has_one :billing_address, dependent: :destroy # class_name: 'Address', dependent: :destroy
  has_one :shipping_address, dependent: :destroy # class_name: 'Address', dependent: :destroy

  accepts_nested_attributes_for :billing_address 
  accepts_nested_attributes_for :shipping_address

  validates :first_name, :last_name, presence: true, length: { in: 1..30 }
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  validates_uniqueness_of :email, case_sensitive: false
  validates :admin, inclusion: { in: [true, false] }

  def admin?
    admin ? true : false
  end

  def name
    [first_name, last_name].join(' ')
  end
end
