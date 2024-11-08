class Product < ApplicationRecord
  enum :status, { "非公開": 0, "公開": 1 }

  has_one_attached :image

  validates :name, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :status, presence: true, inclusion: { in: statuses.keys }

  scope :default_order, -> { order(id: :asc) }
end
