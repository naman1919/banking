class RemoveFieldsFromTransactions < ActiveRecord::Migration[5.2]
  def change
    remove_column :transactions, :from_account_no, :string
    remove_column :transactions, :to_account_no, :string
  end
end
