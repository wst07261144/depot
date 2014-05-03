class ProductsController < ApplicationController
  before_action :is_admin

  def index
    @subject = '商品列表'
    @user = User.find_by(id:session[:user_id]).name
    products = Product.all
    @products = generate_products_for_page(products)
  end

  def new
    @subject = '创建新商品'
    @product = Product.new
    @user = User.find(session[:user_id]).name
  end

  def create
    @product = Product.new(product_params)
    @product.user_id = session[:user_id]
    if @product.save
      session[:product_id] = @product.id
      redirect_to '/products/next_step'
    else
      render 'new'
    end
  end

  def update
    product =  Product.find(params[:id])
    product.update_attributes(params[:product].permit!)
    redirect_to '/products/next_step/'+ (params[:id])
  end

  def color_size_image
    @user = User.find(session[:user_id]).name
    @subject = '设置商品属性'
  end

  def edit_color_size_image
    @user = User.find(session[:user_id]).name
    @subject = '编辑商品属性'
    @data = Product.fetch_edit_data(params[:id])
  end

  def save_product_attr
    Product.save_product_attrs(session[:product_id]||params[:id], params)
    render :text=>'ok'
  end

  def show
    @subject = '商品详情'
    @user = User.find(session[:user_id]).name
    @product = Product.find params[:format]
    @color = @product.product_colors.pluck(:color)
    @size = @product.product_sizes.pluck(:size)
    @image = @product.product_images.pluck(:image_url)
    @images = @product.product_images.pluck(:image_url) - [@product.product_images.pluck(:image_url)[0]]
  end

  def edit
    @subject = '编辑商品'
    @user= User.find(session[:user_id]).name
    @product =  Product.find(params[:id])
  end

  def girl_tops
    @subject = '商品列表'
    @user = User.find_by(id:session[:user_id]).name
    products = Product.where(sort: '女士上装')
    @products = generate_products_for_page(products)
  end

  def boy_tops
    @subject = '商品列表'
    @user = User.find_by(id:session[:user_id]).name
    products = Product.where( sort: '男士上装')
    @products = generate_products_for_page(products)
  end

  def girl_bottoms
    @subject = '商品列表'
    @user = User.find_by(id:session[:user_id]).name
    products = Product.where(sort: '女士下装')
    @products = generate_products_for_page(products)
  end

  def boy_bottoms
    @subject = '商品列表'
    @user = User.find_by(id:session[:user_id]).name
    products = Product.where(sort: '男士下装')
    @products = generate_products_for_page(products)
  end

  def destroy
    Product.find(params[:id]).destroy
    redirect_to '/products/index'
  end

  def is_admin
    @is_admin = User.find(session[:user_id]).admin == 'admin'
  end

  def add_shopping_cart
    product = ShoppingCart.find_by(color: params[:color], size: params[:size],price: params[:price],
                              user_id: session[:user_id],product_id: params[:product_id])
    if product.nil?
      pro = Product.find(params[:product_id])
      @shopping_cart = ShoppingCart.create(color: params[:color], size: params[:size], num: params[:num],
                    price: params[:price], user_id: session[:user_id],product_id: params[:product_id],
                    name: pro.title, img: pro.product_images.first.image_url)
      render text: 'ok'
    else
      product.update_attribute(:num, product.num + params[:num].to_i)
      render text: 'ok'
    end
  end

  def shopping_cart_index
    @subject = '我的购物车'
    @user = User.find(session[:user_id]).name
    #@products = ShoppingCart.all
    @products = ShoppingCart.where(user_id: session[:user_id])
  end

  def destroy_from_shopping_cart
    ShoppingCart.find(params[:id]).destroy
    render :text=> 'ok'
  end

  def buy

  end

  def handle_img
    require 'fileutils'
    xls_tmp = params[:upload_file][:user_info_file]
    xls_position = File.join('app/assets/images', session[:user_id].to_s + '_' + Time.now.to_i.to_s  + '_upload.png')
    FileUtils.cp xls_tmp.path, xls_position
    render text: 'ok'
  end

  def save_orders
    order = JSON.parse(params[:orders])
    address = CustomerAddress.create(user_id: session[:user_id], name: order['name'], phone: order['phone'],
                           address: order['address'])
    shopping_cart = ShoppingCart.find_by(id: order['shopping_cart_id'].to_i)

    address.orders.create(user_id: session[:user_id], product_id: shopping_cart.product_id,name: shopping_cart.name,
                          color: shopping_cart.color, num: shopping_cart.num, size: shopping_cart.size,
                          price: shopping_cart.price, total_price: shopping_cart.num * shopping_cart.price,
                          img: shopping_cart.img)
    render :text=>'ok'
  end

  def save_order_direct
    order = JSON.parse(params[:orders])
    address = CustomerAddress.create(user_id: session[:user_id], name: order['name'], phone: order['phone'],
                                     address: order['address'])
    address.orders.create(user_id: session[:user_id], product_id: order['product_id'],name: order['title'],
                          color: order['color'], num: order['num'], size: order['size'],
                          price: order['price'], total_price: order['price'].to_i * order['num'].to_i,
                          img: order['image'])
    render :text=>'ok'
  end

  def order_index
    @subject = '我的订单'
    @user = User.find_by(id:session[:user_id]).name
    @products = Order.where(user_id: session[:user_id])
  end

  private

  def product_params
    params.require(:product).permit(:title, :mian_liao, :logo, :pic_source, :season, :style, :hou_bao, :huo_hao, :price, :user_id)
  end

  def generate_products_for_page(products)
    display = []
    products.each do |product|

      color = product.product_colors.pluck(:color)
      size = product.product_sizes.pluck(:size)
      img = product.product_images.pluck(:image_url)
      display.push({id: product.id, title:product.title, logo:product.logo, size: size.join(' '),color: color.join(' '), image_url: img[0]})
    end
    display
  end
end