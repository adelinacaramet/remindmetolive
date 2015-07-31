module UrlHelper

  def image_url image, path=''
    image_with_path = build_image_with_path image, path
    if Rails.env.production?
      "http://static.remindmetolive.com/images/#{image_with_path}"
    else
      "/images/#{image_with_path}"
    end
  end

  def image_path post_meta
    "#{post_meta.category}/#{post_meta.publish_date.strftime("%F")}-#{post_meta.url_key}"
  end

  def self.included(base)
    base.extend UrlHelper
  end

private
  def build_image_with_path image, path
    image_with_path = "#{path}/#{image}"
    if path.empty?
      image_with_path = "#{image}"
    end
    image_with_path
  end
end
