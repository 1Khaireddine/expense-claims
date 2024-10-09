# spec/controllers/expenses_controller_spec.rb
require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do
  let(:user) { create(:user) }
  let(:expense) { create(:expense, user: user) }

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns @expenses' do
      Expense.destroy_all
      expense = create(:expense)
      get :index
      expect(assigns(:expenses)).to eq([ExpenseDecorator.new(expense)])
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: expense.id }
      expect(response).to be_successful
    end

    it 'assigns @expense' do
      get :show, params: { id: expense.id }
      expect(assigns(:expense)).to eq(expense)
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      get :edit, params: { id: expense.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new expense' do
        user = create(:user)
        post :create, params: { expense: attributes_for(:expense, user_id: user.id) }
        puts @controller.instance_variable_get(:@expense).errors.full_messages # Outputs validation errors
        expect {
          post :create, params: { expense: attributes_for(:expense, user_id: user.id) }
        }.to change(Expense, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new expense' do
        expect {
          post :create, params: { expense: attributes_for(:expense, description: nil) }
        }.to_not change(Expense, :count)
      end

      it 'renders the new template' do
        post :create, params: { expense: attributes_for(:expense, description: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the expense' do
        patch :update, params: { id: expense.id, expense: { description: 'Updated description' } }
        expense.reload
        expect(expense.description).to eq('Updated description')
      end

      it 'redirects to the expense' do
        patch :update, params: { id: expense.id, expense: { description: 'Updated description' } }
        expect(response).to redirect_to(expense)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the expense' do
        patch :update, params: { id: expense.id, expense: { description: nil } }
        expense.reload
        expect(expense.description).to_not be_nil
      end

      it 'renders the edit template' do
        patch :update, params: { id: expense.id, expense: { description: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the expense' do
      expense
      expect {
        delete :destroy, params: { id: expense.id }
      }.to change(Expense, :count).by(-1)
    end

    it 'redirects to the index' do
      delete :destroy, params: { id: expense.id }
      expect(response).to redirect_to(expenses_path)
    end
  end

  describe 'GET #status' do
    it 'returns a successful response' do
      get :status
      expect(response).to be_successful
    end

    it 'assigns @totals_by_year' do
      get :status
      expect(assigns(:totals_by_year)).not_to be_nil
    end
  end

  describe 'GET #monthly_status' do
    let(:year) { 2023 }

    it 'returns a successful response' do
      get :monthly_status, params: { year: year }
      expect(response).to be_successful
    end

    it 'assigns @monthly_totals' do
      get :monthly_status, params: { year: year }
      expect(assigns(:monthly_totals)).not_to be_nil
    end
  end
end
