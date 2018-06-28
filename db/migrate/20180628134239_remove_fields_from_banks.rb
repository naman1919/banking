class RemoveFieldsFromBanks < ActiveRecord::Migration[5.2]
  def change
    remove_column :banks, :user_id, :integer
    remove_column :banks, :account_id, :integer
  end
end
