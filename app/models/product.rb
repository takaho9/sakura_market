class Product < ApplicationRecord
  enum :status, { unpublish: 0, publish: 1, discarded: 99 }
  STATUS_NAMES = { unpublish: "非公開", publish: "公開", discarded: "削除済み" }.freeze
  ransacker :status, formatter: proc { |v| statuses[v] } do |parent|
    parent.table[:status]
  end

  has_one_attached :image

  validates :name, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :status, presence: true, inclusion: { in: statuses.keys }

  scope :default_order, -> { order(id: :asc) }
  scope :setting_order, ->(display_order) {
    case display_order
    when "priority"
      order(priority: :desc)
    when "newest"
      order(created_at: :desc)
    when "oldest"
      order(created_at: :asc)
    when "price_low_to_high"
      order(price: :asc)
    when "price_high_to_low"
      order(price: :desc)
    else
      order(id: :asc)
    end
  }

  def status_name
    STATUS_NAMES[status.to_sym]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "description", "id", "name", "price", "priority", "status", "updated_at" ]
  end
end
