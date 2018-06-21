class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :father_name, :string
    add_column :users, :mother_name, :string
    add_column :users, :occupation, :string
    add_column :users, :father_occupation, :string
    add_column :users, :mother_occupation, :string
    add_column :users, :mobile_no, :integer, :precision => 12
    add_column :users, :bank_name, :string
    add_column :users, :social_security_no, :string
    add_column :users, :pan, :string
    add_column :users, :document, :string
    add_column :users, :user_photo, :string
  end
end
