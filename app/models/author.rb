class Author < ActiveRecord::Base
  has_many :books

  validates :first_name, :last_name, presence: true, length: { in: 1..30 }

  def name
    [first_name, last_name].join(' ')
  end
end
