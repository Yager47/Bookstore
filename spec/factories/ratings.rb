FactoryGirl.define do
  factory :rating do
    value Faker::Number.between(1, 10)
    review Faker::Lorem.paragraph
  end
end
