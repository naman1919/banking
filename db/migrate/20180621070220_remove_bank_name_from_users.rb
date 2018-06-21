class RemoveBankNameFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :bank_name, :string
  end
end
