class AddVerifyBooleanToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :verify, :boolean
  end
end
