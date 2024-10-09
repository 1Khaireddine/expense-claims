# spec/models/expense_spec.rb
require 'rails_helper'

RSpec.describe Expense, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      expense = build(:expense)
      expect(expense).to be_valid
    end

    it 'is not valid without a description' do
      expense = build(:expense, description: nil)
      expect(expense).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      user = create(:user)
      expense = create(:expense, user: user)
      expect(expense.user).to eq(user)
    end
  end
end
