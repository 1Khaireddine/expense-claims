# spec/factories/expenses.rb
FactoryBot.define do
  factory :expense do
    expense_date { Faker::Date.backward(days: 365) }
    description { Faker::Commerce.product_name }
    amount { Faker::Commerce.price(range: 100.0..1000.0) }
    approved { [true, false].sample }
    association :user

    trait :approved do
      approved { true }
    end

    trait :unapproved do
      approved { false }
    end
  end
end
