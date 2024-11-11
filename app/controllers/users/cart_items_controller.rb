class Users::CartItemsController < Users::ApplicationController
  include Chargeable

  before_action :authenticate_user!

  def index
    set_charge
    @cart_items = current_user.cart_items.includes(product: { image_attachment: :blob })
  end

  def create
    @cart_item = current_user.cart_items.find_by(product_id: params[:product_id])
    if @cart_item
      @cart_item.increment!(:quantity)
    else
      current_user.cart_items.create!(product_id: params[:product_id])
    end
    redirect_to products_path, notice: "カートに商品を追加しました"
  end

  def increment
    current_user.cart_items.find(params[:id]).increment!(:quantity)

    redirect_to cart_items_path
  end

  def decrement
    @cart_item = current_user.cart_items.find(params[:id])

    if @cart_item.quantity <= 1
      @cart_item.destroy
    else
      @cart_item.decrement!(:quantity)
    end

    redirect_to cart_items_path
  end

  def destroy
    @cart_item = current_user.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end
end
