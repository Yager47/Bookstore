require 'rails_helper'

RSpec.describe Author, type: :model do
  let(:author) { create :author }

  it { should validate_presence_of(:first_name) }
  it { should validate_length_of(:first_name) }

  it { should validate_presence_of(:last_name) }
  it { should validate_length_of(:last_name) }

  it { should have_many(:books) }

  context '#name' do 
    let(:full_name) { "#{author.first_name} #{author.last_name}" }
    
    it 'returns full name of author' do
      expect(full_name).to eq(author.name)
    end
  end
end