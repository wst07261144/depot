class CreateImageUrls < ActiveRecord::Migration
  def change
    create_table :image_urls do |t|

      t.integer :product_id
      t.string :image_url

      t.timestamps
    end
  end
end
