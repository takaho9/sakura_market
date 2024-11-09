class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy

  validates :postal_code, format: { with: /\A\d{3}-?\d{4}\z/, message: "は「123-4567」または「1234567」の形式で入力してください" }
end
