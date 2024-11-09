class User < ApplicationRecord
  before_save :format_postal_code

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy

  validates :postal_code, format: { with: /\A\d{3}-?\d{4}\z/, message: "は「123-4567」または「1234567」の形式で入力してください" }

  scope :default_order, -> { order(id: :asc) }

  private

  def format_postal_code
    self.postal_code = postal_code.insert(3, "-") if postal_code.present? && postal_code.length == 7
  end
end
