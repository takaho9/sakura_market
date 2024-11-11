class Users::ProductsController < Users::ApplicationController
  def index
    @products = Product.with_attached_image.publish
  end

  def show
    @product = Product.find(params[:id])
  end
end
