class CreateProductShoppingCartShips < ActiveRecord::Migration
  def change
    create_table :product_shopping_cart_ships do |t|

      t.timestamps
    end
  end
end
