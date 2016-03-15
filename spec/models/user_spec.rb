require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }

  it { should validate_presence_of(:first_name) }
  it { should validate_length_of(:first_name) }

  it { should validate_presence_of(:last_name) }
  it { should validate_length_of(:last_name) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should allow_values('smth1@mail.com', 'blabla00111@qwerty.net').for(:email) }
  it { should_not allow_values('smth1@mail', 'smth.com', 'just_word').for(:email) }

  it { should validate_inclusion_of(:admin).in_array([true, false]) }

  it { should have_many(:ratings) }
  it { should have_many(:orders).dependent(:destroy) }
  it { should have_many(:credit_cards) }

  it { should have_one(:billing_address).dependent(:destroy) }
  it { should have_one(:shipping_address).dependent(:destroy) }

  it { should accept_nested_attributes_for(:billing_address) }
  it { should accept_nested_attributes_for(:shipping_address) }

  context '#admin?' do
    it 'returns false if user is not an admin' do 
      expect(user.admin?).to be_falsey
    end

    it 'returns true if user is an admin' do 
      user.admin = true
      expect(user.admin?).to be_truthy
    end
  end

  context '#name' do 
    let(:full_name) { "#{user.first_name} #{user.last_name}" }
    
    it 'returns full name of user' do
      expect(full_name).to eq(user.name)
    end
  end
end