class ProductsController < ApplicationController
  before_action :find_product, only: %i[show edit update confirm_destroy destroy]

  def index
    @products = Product.order("UPPER(name)").page(page).per(12)
  end

  def show; end

  def edit; end

  def confirm_destroy; end

  def destroy
    @product.destroy
    redirect_to products_path, status: :see_other, success: 'product deleted successfully'
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(permitted_create_params)
    if @product.save
      redirect_to @product, status: :created, success: 'product created successfully!'
    else
      flash[:error] = @product.errors.full_messages.map(&:downcase).join(', ')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(permitted_update_params)
      redirect_to @product, status: :ok, success: 'update successful!'
    else
      flash[:error] = @product.errors.full_messages.map(&:downcase).join(', ')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def permitted_update_params
    params.require(:product).permit(:name, :description, :price)
  end

  def permitted_create_params
    params.require(:product).permit(:name, :description, :price, :quantity)
  end

  def find_product
    @product = Product.find_by(id: params["id"])

    redirect_to products_path if @product.nil?
  end

  def page
    params[:page] || 1
  end
end
