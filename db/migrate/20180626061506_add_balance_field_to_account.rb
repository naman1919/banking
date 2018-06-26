class AddBalanceFieldToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :balance, :bigint
  end
end
