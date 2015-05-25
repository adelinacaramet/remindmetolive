class StoryMeta
  include Virtus.model

  attribute :title, String
  attribute :picture_url, String
  attribute :url, String
  attribute :description, String
  attribute :url_key, String
  attribute :tags, []
  attribute :keywords, String
  attribute :category, String
  attribute :status, String

  def self.get_published
    self.get_all.select { |story_meta| story_meta.status == 'published' }
  end

  def self.get_all
    story_meta_paths = StoryMeta.get_story_meta_paths
    StoryMeta.create_story_metas story_meta_paths
  end

  def self.parse_meta_file meta_path
    meta_hash = Hash[File.read(meta_path).split("\n").map{|i|i.split(': ')}]
    tags = extract_tags meta_hash['tags']
    category = extract_category tags
    story_meta = StoryMeta.new title: meta_hash['title'],
                               picture_url: meta_hash['picture_url'],
                               url: Story.url_by_key(meta_hash['url_key']),
                               description: meta_hash['description'],
                               url_key: meta_hash['url_key'],
                               tags: tags,
                               keywords: meta_hash['keywords'],
                               category: category,
                               status: meta_hash['status']
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

  def self.extract_tags tags_string
    tags = tags_string.strip.split(',').map {|tag| tag.strip}
  end

  def self.extract_category tags
    return '' if tags.empty?
    tags.first.strip.capitalize
  end
end