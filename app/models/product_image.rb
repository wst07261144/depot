class ProductImage < ActiveRecord::Base

  validates :title, presence: true
  validates :mian_liao, presence: true
  validates :logo, presence: true
  validates :pic_source, presence: true
  validates :season, presence: true
  validates :style, presence: true
  validates :hou_bao, presence: true
  validates :huo_hao, presence: true
  validates :price, :numericality => {:greater_than_equal_to => 0.01}

end
