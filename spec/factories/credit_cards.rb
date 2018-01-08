FactoryGirl.define do
  factory :credit_card do
    number Faker::Business.credit_card_number
    cvv Faker::Number.number(3)
    expiration_date Faker::Business.credit_card_expiry_date
  end
end
