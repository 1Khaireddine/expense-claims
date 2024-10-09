class CreateExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :expenses do |t|
      t.date :expense_date
      t.text :description
      t.float :amount
      t.boolean :approved, default: :false
      t.bigint :user_id

      t.timestamps

      t.index :user_id
    end
  end
end
