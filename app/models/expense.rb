class Expense < ApplicationRecord
  belongs_to :user

  validates :expense_date, :description, :amount, presence: true

end
