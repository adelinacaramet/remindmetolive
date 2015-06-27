require 'slim'

class Story
  include Virtus.model

  attribute :html, String
  attribute :story_meta, StoryMeta

  def self.get_published_by_url_key url_key
    Rails.cache.fetch("/stories/#{url_key}") do
      story_meta = StoryMeta.get_published_story_meta_by url_key

      story_path = Rails.root.join('stories', "#{story_meta.story_file_name}").to_s
      slim_template = Slim::Template.new(story_path)
      story_html = slim_template.render(self)

      story = Story.new html: story_html, story_meta: story_meta
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
