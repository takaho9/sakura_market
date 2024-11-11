class Order < ApplicationRecord
  enum status: { pending: 0, confirmed: 1, preparing: 2, shipped: 3, canceled: 99 }
  STATUS_NAME = { pending: "未確定", confirmed: "確定", preparing: "準備中", shipped: "発送済み", canceled: "キャンセル" }.freeze

  belongs_to :user
  has_many :order_items, dependent: :destroy

  def num_of_items
    order_items.sum { |order_item| order_item.quantity }
  end

  def sub_total
    order_items.sum { |order_item| order_item.price * order_item.quantity }
  end

  def status_name
    STATUS_NAME[status.to_sym]
  end
end
