# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

5.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end

years = (2020..2024).to_a
months = (1..12).to_a

user_ids = User.all.pluck(:id)

years.each do |year|
  months.each do |month|
    rand(5..10).times do
      Expense.create!(
        expense_date: Faker::Date.between(from: Date.new(year, month, 1), to: Date.new(year, month, -1)),
        description: Faker::Commerce.product_name,
        amount: Faker::Commerce.price(range: 10..1000),
        approved: [true, false].sample,
        user_id: user_ids.sample
      )
    end
  end
end
