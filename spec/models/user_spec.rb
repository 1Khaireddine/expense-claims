# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is not valid without a first_name' do
      user = build(:user, first_name: nil)
      expect(user).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many expenses' do
      user = create(:user)
      expense1 = create(:expense, user: user)
      expense2 = create(:expense, user: user)
      expect(user.expenses).to include(expense1, expense2)
    end
  end
end
