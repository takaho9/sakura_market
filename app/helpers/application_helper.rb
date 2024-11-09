module ApplicationHelper
  def display_square_image(image, options = {})
    options[:class] = "#{options[:class]} square-box".strip

    if image.attached?
      image_tag image, options
    else
      image_tag "placeholder.png", options
    end
  end
end
