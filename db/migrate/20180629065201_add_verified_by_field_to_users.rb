class AddVerifiedByFieldToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :verified_by, :string
  end
end
