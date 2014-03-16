class ProductsController < ApplicationController

  def index
    @user = User.find_by(id:session[:user_id]).name
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to '/products/index'
    else
      render 'new'
    end
  end

  def show
    @product = Product.find params[:id]

  end

  def edit
  end

  def girl_tops
    @products = Product.all
  end

  private

  def product_params
    params.require(:product).permit(:name, :title, :description, :image_url, :price)
  end

end
