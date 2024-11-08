class Users::ProductsController < Users::ApplicationController
  def index
    @products = Product.publish
  end

  def show
    @product = Product.find(params[:id])
  end
end
