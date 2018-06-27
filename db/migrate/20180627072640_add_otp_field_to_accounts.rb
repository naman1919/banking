class AddOtpFieldToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :otp, :string
  end
end
