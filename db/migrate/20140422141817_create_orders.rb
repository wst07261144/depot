class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :customer_address_id
      t.string :color
      t.string :num
      t.string :size

      t.timestamps
    end
  end
end
