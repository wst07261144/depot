class CreateShoppingCarts < ActiveRecord::Migration
  def change
    create_table :shopping_carts do |t|
      t.integer :user_id
      t.integer :product_id
      t.string :color
      t.string :size
      t.integer :num
      t.decimal :price

      t.timestamps
    end
  end
end
