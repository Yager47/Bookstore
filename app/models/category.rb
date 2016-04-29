class Category < ActiveRecord::Base
  has_many :books

  validates :title, presence: true, uniqueness: true, length: { in: 1..30 }
end
