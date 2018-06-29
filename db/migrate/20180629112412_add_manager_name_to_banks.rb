class AddManagerNameToBanks < ActiveRecord::Migration[5.2]
  def change
    add_column :banks, :manager_name, :string
  end
end
