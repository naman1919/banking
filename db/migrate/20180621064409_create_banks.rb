class CreateBanks < ActiveRecord::Migration[5.2]
  def change
    create_table :banks do |t|
      t.string :name
      t.integer :user_id
      t.integer :account_id

      t.timestamps
    end
  end
end
