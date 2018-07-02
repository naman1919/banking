class AddMobileNoFieldToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :mobile_no, :bigint
  end
end
