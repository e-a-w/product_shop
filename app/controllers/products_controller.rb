class ProductsController < ApplicationController
  before_action :find_product, only: %i[show edit update]

  def index
    @products = Product.all
  end

  def show; end

  def edit; end

  def update
    if @product.update(permitted_update_params)
      redirect_to @product, success: 'update successful!'
    else
      flash[:error] = @product.errors.full_messages.map(&:downcase).join(', ')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def permitted_update_params
    params.require(:product).permit(:name, :description, :price)
  end

  def find_product
    @product = Product.find_by(id: params["id"])

    redirect_to products_path if @product.nil?
  end
end
