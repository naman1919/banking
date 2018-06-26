class AddAccountNumberToBeneficiaries < ActiveRecord::Migration[5.2]
  def change
    add_column :beneficiaries, :account_no, :string
  end
end
