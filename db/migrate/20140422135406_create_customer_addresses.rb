class CreateCustomerAddresses < ActiveRecord::Migration
  def change
    create_table :customer_addresses do |t|
      t.integer :user_id
      t.string :name
      t.string :phone
      t.string :address

      t.timestamps
    end
  end
end
