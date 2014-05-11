class Product < ActiveRecord::Base

  has_many :product_colors, dependent: :destroy
  has_many :product_images, dependent: :destroy
  has_many :product_sizes, dependent: :destroy

  validates :title,  presence: true, uniqueness: true
  validates :mian_liao,  presence: true
  validates :logo,  presence: true
  validates :pic_source,  presence: true
  validates :season,  presence: true
  validates :style,  presence: true
  validates :hou_bao,  presence: true
  validates :huo_hao,  presence: true
  validates :price, :numericality => {:greater_than_equal_to => 0.01}

  def self.save_product_attrs(product_id, data)
    id = product_id || data['id']
    product = Product.find_by(id: id)
    product.sort = data['sort'][0]
    product.save

    data['color'].each do |col|
      product.product_colors.find_by(color: col).nil? ? product.product_colors.create(color: col): {}
    end
    del = product.product_colors.pluck(:color) - data['color']
    ProductColor.delete_all(product_id: product_id,color: del) if del.length != 0

    data['size'].each do |size|
      product.product_sizes.find_by(size:size).nil? ? product.product_sizes.create(size: size):{}
    end
    del_size = product.product_sizes.pluck(:size) - data['size']
    ProductSize.delete_all(product_id:product_id, size:del_size)

  end

  def self.fetch_edit_data(product_id)
    product = Product.find_by(id: product_id)
    color = product.product_colors.pluck(:color)
    size = product.product_sizes.pluck(:size)
    img = product.product_images.pluck(:image_url)
    {color:color,size:size,image_url:img ,product_id:product_id,sort:product.sort}.to_json
  end

end
