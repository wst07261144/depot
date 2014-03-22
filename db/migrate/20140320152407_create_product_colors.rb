class CreateProductColors < ActiveRecord::Migration
  def change
    create_table :product_colors do |t|
      t.integer :product_id
      t.string :color
      t.timestamps
    end
  end
end
