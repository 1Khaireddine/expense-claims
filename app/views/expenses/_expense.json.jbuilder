json.extract! expense, :id, :claimer_name, :expense_date, :description, :amount, :approved, :created_at, :updated_at
json.url expense_url(expense, format: :json)
