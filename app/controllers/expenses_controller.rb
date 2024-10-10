class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[ show edit update destroy approved]

  def index
    @expenses = Expense.includes(:user)
                        .order(created_at: :desc)
                        .page(params[:page])
                        .per(10)

    @decorated_expenses = @expenses.map { |expense| ExpenseDecorator.new(expense) }
  end

  def show
  end

  def new
    @expense = Expense.new
  end

  def edit
  end

  def create
    @expense = Expense.new(expense_params)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to @expense, notice: "Expense was successfully created." }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to @expense, notice: "Expense was successfully updated." }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @expense.destroy!

    respond_to do |format|
      format.html { redirect_to expenses_path, status: :see_other, notice: "Expense was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def approved
    if @expense.update(approved: true)
      respond_to do |format|
        format.html { redirect_to expenses_path, status: :see_other, notice: "Expense was successfully approved." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to expenses_path, status: :unprocessable_entity, alert: "Expense approval failed." }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def status

    @expenses = Expense.all

    @totals_by_year = @expenses.group_by { |expense| expense.expense_date.year }.transform_values do |expenses|
      total_amount = expenses.sum(&:amount)
      total_approved = expenses.select(&:approved).sum(&:amount)
      total_not_approved = expenses.reject(&:approved).sum(&:amount)

      {
        total_amount: total_amount,
        total_approved: total_approved,
        total_not_approved: total_not_approved
      }
    end
  end

  def monthly_status
    @year = params[:year].to_i
    @monthly_totals = Expense.where("extract(year from expense_date) = ?", @year)
                              .group_by { |expense| expense.expense_date.month }
                              .transform_values do |expenses|
      total_amount = expenses.sum(&:amount)
      total_approved = expenses.select(&:approved).sum(&:amount)
      total_not_approved = expenses.reject(&:approved).sum(&:amount)

      {
        total_amount: total_amount,
        total_approved: total_approved,
        total_not_approved: total_not_approved
      }
    end
  end

  private
    def set_expense
      @expense = Expense.find(params[:id])
    end

    def expense_params
      params.require(:expense).permit(:user_id, :expense_date, :description, :amount, :approved)
    end
end
