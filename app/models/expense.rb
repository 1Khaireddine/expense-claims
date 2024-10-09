class Expense < ApplicationRecord
  belongs_to :user

  validates :expense_date, :description, :amount, presence: true


  scope :grouped_by_month_and_year, -> {
    select("DATE_TRUNC('month', expense_date) as month, DATE_PART('year', expense_date) as year, COUNT(*) as total_expenses, SUM(CASE WHEN approved THEN 1 ELSE 0 END) as approved_expenses")
    .group("DATE_TRUNC('month', expense_date), DATE_PART('year', expense_date)")
    .order("year DESC, month DESC")
  }
end
