class AddFieldsToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :user_id, :integer
    add_column :transactions, :from_account_no, :string
    add_column :transactions, :credit, :boolean
    add_column :transactions, :debit, :boolean
    add_column :transactions, :to_account_no, :string
  end
end
