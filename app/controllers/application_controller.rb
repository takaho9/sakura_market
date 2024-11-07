class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admins_products_path
    elsif resource.is_a?(User)
      products_path
    end
  end
end
