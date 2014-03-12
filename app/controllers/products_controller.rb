class ProductsController < ApplicationController

  def index
    #@products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    Product.create(params[:product].permit!)
    redirect_to root_path
  end

  def show
    @product = Product.find params[:id]

  end

  def edit
  end

end
