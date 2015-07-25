class CategoryMeta
  include Virtus.model

  attribute :title, String
  attribute :description, String
  attribute :keywords, String
  attribute :category, String

  def self.for_category category
    cached_category_to_meta[category]
  end

  def self.cached_category_to_meta
    Rails.cache.fetch("/category_to_meta") do
      category_to_meta
    end
  end

private

  def self.category_to_meta
    category_to_meta = {}
    all.each do |category_meta|
      category_to_meta[category_meta.category] = category_meta
    end
    category_to_meta
  end

  def self.all
    category_meta_paths = CategoryMeta.category_meta_paths
    CategoryMeta.create_category_metas category_meta_paths
  end

  def self.category_meta_paths
    posts_path = Rails.root.join('posts')
    category_meta_paths = Dir["#{posts_path}/**/category_meta"]
  end

  def self.create_category_metas category_meta_paths
    category_metas = []
    category_meta_paths.each do |category_meta_path|
      category_metas << parse_meta_file(category_meta_path)
    end
    category_metas
  end

  def self.parse_meta_file meta_path
    meta_hash = Hash[File.read(meta_path).split("\n").map{|i|i.split(': ')}]
    CategoryMeta.new title: meta_hash['title'],
                     description: meta_hash['description'],
                     keywords: meta_hash['keywords'],
                     category: meta_hash['category']
  end
end
