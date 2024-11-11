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

  def new
    @order = current_user.orders.build
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
      orderer_last_name: current_user.last_name,
      orderer_first_name: current_user.first_name
    )
    @order.assign_attributes(order_params)
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
      render :new, status: :unprocessable_content
    end
  end

  def confirm
    @order = current_user.orders.find(params[:id])
  end

  def edit
  end

  def update
    begin
      ActiveRecord::Base.transaction do
        @order.confirmed!
        @order.update!(confirmed_at: Time.zone.now)
        current_user.cart_items.destroy_all
      end
      redirect_to orders_path, notice: "注文を確定しました。"
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved
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
      :delivery_date,
      :delivery_time_slot
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
