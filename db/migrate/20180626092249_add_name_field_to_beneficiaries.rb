class AddNameFieldToBeneficiaries < ActiveRecord::Migration[5.2]
  def change
    add_column :beneficiaries, :name, :string
  end
end
