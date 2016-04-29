require 'rails_helper'

RSpec.describe Address, type: :model do
  
  it { should validate_presence_of(:first_name) }
  it { should validate_length_of(:first_name) }

  it { should validate_presence_of(:last_name) }
  it { should validate_length_of(:last_name) }

  it { should validate_presence_of(:city) }
  it { should validate_length_of(:city) }

  it { should validate_presence_of(:street) }
  it { should validate_length_of(:street) }

  it { should validate_presence_of(:country) }
  it { should validate_length_of(:country) }

  it { should validate_presence_of(:phone) }
  it { should allow_values('195949310054', '034133540762').for(:phone) }
  it { should_not allow_values('some_text', '12949234', '-3123420967548235').for(:phone) }

  it { should validate_presence_of(:zipcode) }
  it { should allow_values('10054', '40762').for(:zipcode) }
  it { should_not allow_values('some_text', '12949234', '-31235').for(:zipcode) }
   
  it { should belong_to(:order) }
  it { should belong_to(:user) }
end