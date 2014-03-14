class Product < ActiveRecord::Base

  default_scope :order=>'title'

  validate :title, :description, :image_url, :presence=>true
  validate :price, :numericality => {:greater_than_equal_to => 0.01}
  validate :image_url, :format=>{
      :with => %r{\.(gif|jpg|png)$}i,
      :message => '必须是GIF、JPG、或者PNG类型的URL'
  }
end
