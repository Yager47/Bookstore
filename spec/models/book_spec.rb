require 'rails_helper'

RSpec.describe Book, type: :model do
  it 'is invalid without a first name'

  it 'is invalid without a last name'

  it 'is invalid without an email'

  it 'has unique email'
end
