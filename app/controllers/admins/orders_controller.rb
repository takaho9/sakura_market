class Admins::OrdersController < Admins::ApplicationController
  before_action :set_order, only: %i[show edit update]
  def index
    @orders = Order.not_pending
  end

  def show
    @order_items = @order.order_items.includes(:product)
  end

  def edit
  end

  def update
    if @order.update(order_params)
      redirect_to admins_order_path(@order), notice: "更新しました。"
    else
      redirect_to admins_order_path(@order), alert: "更新できませんでした。"
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:status, :orderer_last_name, :orderer_first_name, :postal_code, :address, :delivery_date, :delivery_time_slot)
  end
end
