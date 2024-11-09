class Users::CartItemsController < Users::ApplicationController
  before_action :authenticate_user!

  def index
    set_charge
    @cart_items = current_user.cart_items
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

  private
  def set_charge
    @num_of_items = current_user.cart_items.sum(:quantity)                                                # 商品の個数
    @sub_total = current_user.cart_items.sum { |cart_item| cart_item.product.price * cart_item.quantity } # 小計
    @cod_fee = FEE[:cod_fee]                                                                              # 代引き手数料
    @shipping_fee_interval = FEE[:shipping_fee_interval]                                                  # 送料が加算される商品数の間隔
    @shipping_fee = FEE[:shipping_fee] * (@num_of_items / @shipping_fee_interval.to_f).ceil               # 送料
    @tax_rate = FEE[:tax_rate]                                                                            # 消費税率
    @total_charge = ((@sub_total + @cod_fee + @shipping_fee) * (1 + @tax_rate)).floor                     # 合計金額
  end
end
