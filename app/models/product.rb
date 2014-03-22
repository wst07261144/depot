class Product < ActiveRecord::Base

  validates :title,  presence: true, uniqueness: true
  validates :mian_liao,  presence: true, uniqueness: true
  validates :logo,  presence: true, uniqueness: true
  validates :pic_source,  presence: true, uniqueness: true
  validates :season,  presence: true, uniqueness: true
  validates :style,  presence: true, uniqueness: true
  validates :hou_bao,  presence: true, uniqueness: true
  validates :huo_hao,  presence: true, uniqueness: true
  validates :price,  presence: true, uniqueness: true
end
