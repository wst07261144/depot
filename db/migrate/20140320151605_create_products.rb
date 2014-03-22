class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :mian_liao
      t.string :logo
      t.string :pic_source
      t.string :season
      t.string :style
      t.string :hou_bao
      t.string :huo_hao

      t.timestamps
    end
  end
end
