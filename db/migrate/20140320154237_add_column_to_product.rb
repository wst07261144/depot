class AddColumnToProduct < ActiveRecord::Migration
  def change
    add_column :products, :price, :decimal
    add_column :products, :sort, :string
  end
end
