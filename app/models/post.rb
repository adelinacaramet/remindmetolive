require 'slim'

class Post
  include Virtus.model
  include UrlHelper

  attribute :html, String
  attribute :post_meta, PostMeta

  def self.get_published_by category, url_key
    Rails.cache.fetch("/posts/#{category}/#{url_key}") do
      post_meta = PostMeta.published_post_meta_by category, url_key

      post_path = Rails.root.join('posts', "#{category}" , "#{post_meta.post_file_name}").to_s
      slim_template = Slim::Template.new(post_path)
      post_html = slim_template.render(self, {post_meta: post_meta, image_path: image_path(post_meta)})

      post = Post.new html: post_html, post_meta: post_meta
    end
  end

  def self.render(name, options = {}, &block)
    template_path = Rails.root.join('app', 'views', 'partials/' "_#{name}.html.slim").to_s
    Slim::Template.new(template_path, {}).render(self, options).html_safe
  end

  def self.url_by_key category, url_key
    "/#{category}/#{url_key}.html"
  end

  def self.publish_day post_meta
    post_meta.publish_date.day
  end

  def self.publish_month post_meta
    post_meta.publish_date.strftime('%B').truncate(3, omission: '')
  end
end
