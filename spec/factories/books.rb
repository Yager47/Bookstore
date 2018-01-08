FactoryGirl.define do
  factory :book do
    title Faker::Book.title
    description Faker::Lorem.paragraph
    price Faker::Number.decimal(2)
    books_in_stock Faker::Number.digit
    sales Faker::Number.digit
  end
end
