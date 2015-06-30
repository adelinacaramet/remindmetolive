class PostMeta
  include Virtus.model

  attribute :title, String
  attribute :picture_url, String
  attribute :url, String
  attribute :description, String
  attribute :url_key, String
  attribute :post_file_name, String
  attribute :tags, []
  attribute :keywords, String
  attribute :category, String
  attribute :status, String
  attribute :layout, String

  def self.categories
    @@url_keys_to_published_post_metas ||= PostMeta.url_keys_to_published_post_metas
    @@url_keys_to_published_post_metas.keys
  end

  def self.get_published_post_meta_by category, url_key
    @@url_keys_to_published_post_metas ||= PostMeta.url_keys_to_published_post_metas
    @@url_keys_to_published_post_metas[category][url_key]
  end

  def self.url_keys_to_published_post_metas
    published_post_metas = PostMeta.get_all_published
    url_keys_to_published_post_metas = {}
    published_post_metas.each do |post_meta|
      if url_keys_to_published_post_metas[post_meta.category].nil?
        url_keys_to_published_post_metas[post_meta.category] = {post_meta.url_key => post_meta }
      else
        url_keys_to_published_post_metas[post_meta.category][post_meta.url_key] = post_meta
      end
    end
    url_keys_to_published_post_metas
  end

  def self.get_published_for_category category
    @@url_keys_to_published_post_metas ||= PostMeta.url_keys_to_published_post_metas
    @@url_keys_to_published_post_metas[category].values
  end

  def self.get_all_published
    self.get_all.select { |post_meta| post_meta.status == 'published' }
  end

  def self.get_all
    post_meta_paths = PostMeta.get_post_meta_paths
    PostMeta.create_post_metas post_meta_paths
  end

  def self.parse_meta_file meta_path
    meta_hash = Hash[File.read(meta_path).split("\n").map{|i|i.split(': ')}]
    tags = extract_tags meta_hash['tags']
    post_meta = PostMeta.new title: meta_hash['title'],
                               picture_url: meta_hash['picture_url'],
                               url: Post.url_by_key(meta_hash['category'], meta_hash['url_key']),
                               description: meta_hash['description'],
                               url_key: meta_hash['url_key'],
                               post_file_name: meta_hash['post_file_name'],
                               tags: tags,
                               keywords: meta_hash['keywords'],
                               category: meta_hash['category'],
                               status: meta_hash['status'],
                               layout: meta_hash['layout']
  end

protected
  def self.get_post_meta_paths
    posts_path = Rails.root.join('posts')
    post_meta_paths = Dir["#{posts_path}/**/*.meta"]
  end

  def self.create_post_metas post_meta_paths
    post_metas = []
    post_meta_paths.each do |post_meta_path|
      post_metas << PostMeta.parse_meta_file(post_meta_path)
    end
    post_metas
  end

  def self.extract_tags tags_string
    tags = tags_string.strip.split(',').map {|tag| tag.strip}
  end
end
