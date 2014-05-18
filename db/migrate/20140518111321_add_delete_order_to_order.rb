class AddDeleteOrderToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :admin_delete, :boolean
    add_column :orders, :user_delete, :boolean
  end
end
