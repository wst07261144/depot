class ProductsController < ApplicationController

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
    @product = Product.find params[:id]
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
    products = Product.where(sort: '男士上装')
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

  private

  def product_params
    params.require(:product).permit(:title, :mian_liao, :logo, :pic_source, :season, :style, :hou_bao, :huo_hao, :price)
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
