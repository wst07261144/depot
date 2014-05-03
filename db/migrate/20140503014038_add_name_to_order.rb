class AddNameToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :name, :string
    add_column :orders, :img, :string
  end
end
