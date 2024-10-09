class ExpenseDecorator < Draper::Decorator
  delegate_all
  include ActionView::Helpers::NumberHelper

  def formatted_amount
    number_to_currency(amount, unit: '€')
  end

  def approval_status
    approved ? 'Approved' : 'Pending Approval'
  end
end