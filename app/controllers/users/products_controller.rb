class Users::ProductsController < Users::ApplicationController
  def index
    display_order = SiteSetting.find_by(key: "display_order_products")&.value
    @products = Product.with_attached_image.publish.setting_order(display_order)
  end

  def show
    @product = Product.find(params[:id])
  end
end
