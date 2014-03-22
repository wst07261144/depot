class Product < ActiveRecord::Base

  has_many :product_colors
  has_many :product_images
  has_many :product_sizes

  validates :title,  presence: true, uniqueness: true
  validates :mian_liao,  presence: true, uniqueness: true
  validates :logo,  presence: true, uniqueness: true
  validates :pic_source,  presence: true, uniqueness: true
  validates :season,  presence: true, uniqueness: true
  validates :style,  presence: true, uniqueness: true
  validates :hou_bao,  presence: true, uniqueness: true
  validates :huo_hao,  presence: true, uniqueness: true
  validates :price, :numericality => {:greater_than_equal_to => 0.01},uniqueness: true

  def self.save_product_attrs(product_id, data)
    product = Product.find_by(id: product_id)
    product.sort = data['sort'][0]
    product.save
    data['color'].each do |col|
      product.product_colors.create(color: col)
    end
    data['image'].each do |img|
       product.product_images.create(image_url: img)
    end
    data['size'].each do |size|
       product.product_sizes.create(size: size)
    end
  end

end
