FactoryGirl.define do
  factory :address do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    country Faker::Address.country
    city Faker::Address.city
    street Faker::Address.street_name
    phone Faker::Number.number(12).to_s
    zipcode Faker::Address.zip_code
  end
end
