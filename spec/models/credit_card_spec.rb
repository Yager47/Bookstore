require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  it { should validate_presence_of(:number) }
  it { should allow_values('1959493100547436', '0041335407623468').for(:number) }
  it { should_not allow_values('some_text', '12949234', '-3123420967548235').for(:number) }

  it { should validate_presence_of(:cvv) }
  it { should allow_values('023', '557').for(:cvv) }
  it { should_not allow_values('032542', '4rw', '!!d', '0-2').for(:cvv) }  

  it { should validate_presence_of(:expiration_date) }
  it { should_not allow_value(Date.today - 1.day).for(:expiration_date) }

  it { should belong_to(:user) }
  it { should belong_to(:order) }
end