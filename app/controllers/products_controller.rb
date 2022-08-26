class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find_by(id: params["id"])

    redirect_to products_path if @product.nil?
  end
end
