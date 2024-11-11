class AddDeliveryDateAndTimeToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :delivery_date, :date
    add_column :orders, :delivery_time_slot, :integer, null: false, default: 99
  end
end
