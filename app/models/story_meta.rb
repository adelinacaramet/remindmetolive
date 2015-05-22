class StoryMeta
  include Virtus.model

  attribute :title, String
  attribute :picture_url, String
  attribute :url, String
  attribute :description, String
  attribute :url_key, String
  attribute :tags, String
  attribute :keywords, String

  def self.get_all
    story_meta_paths = StoryMeta.get_story_meta_paths
    StoryMeta.create_story_metas story_meta_paths
  end

  def self.parse_meta_file meta_path
    meta_hash = Hash[File.read(meta_path).split("\n").map{|i|i.split(': ')}]
    story_meta = StoryMeta.new title: meta_hash['title'],
                               picture_url: meta_hash['picture_url'],
                               url: Story.url_by_key(meta_hash['url_key']),
                               description: meta_hash['description'],
                               url_key: meta_hash['url_key'],
                               tags: meta_hash['tags'],
                               keywords: meta_hash['keywords']
  end

protected
  def self.get_story_meta_paths
    stories_path = Rails.root.join('stories')
    story_meta_paths = Dir["#{stories_path}/*.meta"]
  end

  def self.create_story_metas story_meta_paths
    story_metas = []
    story_meta_paths.each do |story_meta_path|
      story_metas << StoryMeta.parse_meta_file(story_meta_path)
    end
    story_metas
  end
end