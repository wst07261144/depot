class Product < ActiveRecord::Base

  default_scope :order => 'title'

  validates :title, presence: true
  validates :description, presence: true
  validates :image_url, presence: true, uniqueness: true
  validates :image_url1, uniqueness: true
  validates :image_url2, uniqueness: true
  validates :image_url3, uniqueness: true
  validates :image_url4, uniqueness: true
  validates :price, :numericality => {:greater_than_equal_to => 0.01}
  #validates_format_of :image_url,
  #    :with=> %r{\A/*(gif|jpg|png)\z}i,
  #    :message => '必须是GIF、JPG、或者PNG类型的URL'

end
