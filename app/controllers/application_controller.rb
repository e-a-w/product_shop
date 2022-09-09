class ApplicationController < ActionController::Base
  add_flash_types :error, :success

  before_action :set_dropdown_options

  private

  def set_dropdown_options
    products_by_category = Category.departments.each_with_object({}) { |(k, _v), a| a[k] = "/products/department/#{k}" }

    @manage_products_dropdown = {
      "create product" => :new_product
    }

    @find_products_dropdown = {
      "all products" => :root,
      "featured" => :featured_products,
      "top-sellers" => :root,
      "clearance" => :clearance_products,
      "by category" => products_by_category,
      "advanced search" => :advanced_search_form_products
    }
  end
end
