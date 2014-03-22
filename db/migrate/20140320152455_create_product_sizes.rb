class CreateProductSizes < ActiveRecord::Migration
  def change
    create_table :product_sizes do |t|
      t.integer :product_id
      t.string :size
      t.timestamps
    end
  end
end
