require 'slim'

class Story
  include Virtus.model

  attribute :html, String
  attribute :story_meta, StoryMeta

  def self.get_by_url_key url_key
    story_path = Rails.root.join('stories', "#{url_key}.slim").to_s
    slim_template = Slim::Template.new(story_path)
    story_html = slim_template.render(self)

    meta_path = Rails.root.join('stories', "#{url_key}.meta").to_s
    story_meta = StoryMeta.parse_meta_file meta_path

    story = Story.new html: story_html, story_meta: story_meta
  end

  def self.render(name, options = {}, &block)
    template_path = Rails.root.join('app', 'views', 'partials/' "_#{name}.html.slim").to_s
    Slim::Template.new(template_path, options).render(self, options).html_safe
  end

  def self.url_by_key url_key
    "/stories/#{url_key}.html"
  end
end
