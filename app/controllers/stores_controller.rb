class StoresController < ApplicationController
  def index
    @product = Product.all
  end
end
