require 'slim'

class Post
  include Virtus.model

  attribute :html, String
  attribute :post_meta, PostMeta

  def self.get_published_by_url_key url_key
    Rails.cache.fetch("/posts/#{url_key}") do
      post_meta = PostMeta.get_published_post_meta_by url_key

      post_path = Rails.root.join('posts', "#{post_meta.post_file_name}").to_s
      slim_template = Slim::Template.new(post_path)
      post_html = slim_template.render(self)

      post = Post.new html: post_html, post_meta: post_meta
    end
  end

  def self.render(name, options = {}, &block)
    template_path = Rails.root.join('app', 'views', 'partials/' "_#{name}.html.slim").to_s
    Slim::Template.new(template_path, {}).render(self, options).html_safe
  end

  def self.url_by_key url_key
    "/stories/#{url_key}.html"
  end
end
