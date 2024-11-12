class SiteSetting < ApplicationRecord
  DISPLAY_ORDER_PRODUCT_OPTIONS = {
    priority: "優先度",
    newest: "作成日（新しい順）",
    oldest: "作成日（古い順）",
    price_low_to_high: "価格（安い順）",
    price_high_to_low: "価格（高い順）"
  }.freeze
end
