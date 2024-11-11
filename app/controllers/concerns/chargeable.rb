# app/controllers/concerns/chargeable.rb
module Chargeable
  extend ActiveSupport::Concern

  private

  def set_charge
    cart_items = current_user.cart_items.includes(:product)

    @num_of_items = cart_items.sum(:quantity)                                                # 商品の個数
    @sub_total = cart_items.sum { |cart_item| cart_item.product.price * cart_item.quantity } # 小計
    @cod_fee = FEE[:cod_fee].find { |fee| fee[:range].cover?(@sub_total) }[:fee]
    @shipping_fee_interval = FEE[:shipping_fee_interval]                                                  # 送料が加算される商品数の間隔
    @shipping_fee = FEE[:shipping_fee] * (@num_of_items / @shipping_fee_interval.to_f).ceil               # 送料
    @tax_rate = FEE[:tax_rate]                                                                            # 消費税率
    @total_charge = ((@sub_total + @cod_fee + @shipping_fee) * (1 + @tax_rate)).floor                     # 合計金額
  end
end
