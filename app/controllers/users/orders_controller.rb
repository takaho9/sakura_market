class Users::OrdersController < Users::ApplicationController
  include Chargeable

  before_action :authenticate_user!
  before_action :set_order, only: %i[show edit update destroy]
  before_action :ensure_address_info_registered, only: %i[create]

  def index
    @orders = current_user.orders.not_pending
  end

  def show
  end

  def create
    set_charge
    @order = current_user.orders.build(
      total_charge: @total_charge,
      cod_fee: @cod_fee,
      tax_rate: @tax_rate,
      shipping_fee: @shipping_fee,
      status: :pending,
      postal_code: current_user.postal_code,
      address: current_user.address,
      last_name: current_user.last_name,
      first_name: current_user.first_name
    )
    current_user.cart_items.each do |cart_item|
      @order.order_items.build(
        product_id: cart_item.product_id,
        quantity: cart_item.quantity,
        price: cart_item.product.price,
        name: cart_item.product.name
      )
    end
    if @order.save
      redirect_to confirm_order_path(@order)
    else
      redirect_to users_cart_items_path, alert: "注文処理に失敗しました。"
    end
  end

  def confirm
    @order = current_user.orders.find(params[:id])
  end

  def edit
  end

  def update
    if @order.confirmed!
      current_user.cart_items.destroy_all
      redirect_to orders_path, notice: "注文を確定しました。"
    else
      redirect_to confirm_order_path(@order), alert: "注文処理に失敗しました。"
    end
  end

  def destroy
    @order.cancel!
    redirect_to users_orders_path, notice: "注文をキャンセルしました。"
  end

  private
  def set_order
    @order = current_user.orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(
      :postal_code,
      :address,
      :last_name,
      :first_name,
      order_items_attributes: %i[product_id quantity]
    )
  end

  def ensure_address_info_registered
    unless current_user.address_info_registered?
      session[:return_to] = request.fullpath
      redirect_to edit_address_user_path, alert: "住所を登録してください。"
    end
  end

  private
  def set_new_order
  end
end
