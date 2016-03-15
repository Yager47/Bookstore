require 'rails_helper'

RSpec.describe Rating, type: :model do
  it { should validate_presence_of(:value) }
  it { should validate_numericality_of(:value) }

  it { should validate_presence_of(:review) }

  it { should belong_to(:book).dependent(:destroy) }
  it { should belong_to(:user) }
end