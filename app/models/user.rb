class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :ratings
  has_many :orders

  validates :first_name, :last_name, :email, presence: true, length: { in: 1..80 }

  def admin?
  	admin
  end

  def name
  	"#{self.first_name} #{self.last_name}"
  end
end
