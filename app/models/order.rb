class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  enum status: {
    pending: 0,
    confirmed: 1,
    preparing: 2,
    shipped: 3,
    canceled: 99
  }
  STATUS_NAMES = {
    pending: "未確定",
     confirmed: "確定",
     preparing: "準備中",
     shipped: "発送済み",
     canceled: "キャンセル"
  }.freeze

  enum delivery_time_slot: {
    eight_to_twelve: 0,
    twelve_to_two: 1,
    two_to_four: 2,
    four_to_six: 3,
    six_to_eight: 4,
    eight_to_nine: 5,
    not_specified: 99
  }
  DELIVERY_TIME_SLOT_NAMES = {
    eight_to_twelve: "8時〜12時",
    twelve_to_two: "12時〜14時",
    two_to_four: "14時〜16時",
    four_to_six: "16時〜18時",
    six_to_eight: "18時〜20時",
    eight_to_nine: "20時〜21時",
    not_specified: "指定なし"
  }.freeze

  validate :delivery_date_within_business_days
  validates :delivery_time_slot, inclusion: { in: delivery_time_slots.keys, allow_nil: true }

  def num_of_items
    order_items.sum { |order_item| order_item.quantity }
  end

  # 　商品の合計金額（税抜き）
  def sub_total
    order_items.sum { |order_item| order_item.price * order_item.quantity }
  end

  def status_name
    STATUS_NAMES[status.to_sym]
  end

  def delivery_time_slot_name
    DELIVERY_TIME_SLOT_NAMES[delivery_time_slot.to_sym]
  end

  def orderer_full_name
    orderer_last_name + " " + orderer_first_name
  end

  def display_address
    postal_code + " " + address
  end

  def num_of_items
    order_items.sum { |order_item| order_item.quantity }
  end

  private

  def delivery_date_within_business_days
    return if delivery_date.blank?

    unless delivery_date >= 3.business_days.from_now &&
           delivery_date <= 14.business_days.from_now
      errors.add(:delivery_date, "は3営業日から14営業日以内で指定してください。")
    end
  end
end
