class AddPriceToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :price, :decimal
    add_column :orders, :total_price, :decimal
  end
end
