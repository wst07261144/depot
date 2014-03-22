class ProductsController < ApplicationController

  def index
    @user = User.find_by(id:session[:user_id]).name
    @products = Product.all
  end

  def new
    @subject = '创建新商品'
    @product = Product.new
    @user = User.find(session[:user_id]).name
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to '/products/next_step'
    else
      render 'new'
    end
  end

  def color_size_image
    @user = User.find(session[:user_id]).name
    @subject = '设置商品属性'
  end

  def show
    @product = Product.find params[:id]

  end

  def edit
  end

  def girl_tops
    @products = Product.all
  end

  def boy_tops
    @products = Product.all
  end

  def girl_bottoms
    @products = Product.all
  end

  def boy_bottoms
    @products = Product.all
  end

  private

  def product_params
    params.require(:product).permit(:title, :mian_liao, :logo, :pic_source, :season, :style, :hou_bao, :huo_hao, :price)
  end

end
