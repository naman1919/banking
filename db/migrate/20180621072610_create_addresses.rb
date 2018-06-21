class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :type
      t.string :house_no
      t.integer :street_no
      t.string :area
      t.string :city
      t.string :state
      t.string :country
      t.integer :pin
      t.text :address_proof

      t.timestamps
    end
  end
end
