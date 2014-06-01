class AddConfirmReceiveToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :confirm_status, :string
  end
end
