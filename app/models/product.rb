class Product < ApplicationRecord
  enum :status, { unpublish: 0, publish: 1 }
  STATUS_NAMES = { unpublish: "非公開", publish: "公開" }.freeze

  has_one_attached :image

  validates :name, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :status, presence: true, inclusion: { in: statuses.keys }

  scope :default_order, -> { order(id: :asc) }

  def status_name
    STATUS_NAMES[status.to_sym]
  end
end
