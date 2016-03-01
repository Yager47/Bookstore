class Author < ActiveRecord::Base
  has_many :books

  validates :first_name, presence: true
  validates :last_name, presence: true

  def name
    "#{self.first_name} #{self.last_name}"
  end
end
