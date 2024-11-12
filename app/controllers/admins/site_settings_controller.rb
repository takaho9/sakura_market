class Admins::SiteSettingsController < Admins::ApplicationController
  def update_display_order_products
    site_setting = SiteSetting.find_or_create_by(key: "display_order_products")
    if site_setting.update(value: params[:site_setting][:value])
      redirect_to admins_products_path, notice: "更新しました。"
    else
      redirect_to admins_products_path, alert: "更新に失敗しました。"
    end
  end
end
