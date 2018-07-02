class RemoveMobileNoFieldFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :mobile_no, :int
  end
end
