class AddImageAndNameToShoppingCart < ActiveRecord::Migration
  def change
    add_column :shopping_carts, :name, :string
    add_column :shopping_carts, :img, :string
  end
end
