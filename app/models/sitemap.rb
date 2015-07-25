class Sitemap
  include Virtus.model

  attribute :entries, Array[SitemapEntry]

  def self.generate
    Sitemap.new entries: generate_entries
  end

private
  def self.generate_entries
    entries = []
    entries << SitemapEntry.new(url: '', changefreq: 'daily', priority: 0.9)
    entries << SitemapEntry.new(url: 'contact/', changefreq: 'weekly', priority: 0.5)
    entries << SitemapEntry.new(url: 'about/', changefreq: 'weekly', priority: 0.5)
    table = PostMeta.cached_published_post_metas_table

    category_urls = []
    table.each_key do |category|
      category_urls << "#{category}/"
    end

    category_urls.each do |url_key|
      entries << SitemapEntry.new(url: url_key, changefreq: 'daily', priority: 0.4)
    end

    post_urls = []
    table.each_pair do |category, url_key_to_post_meta|
      url_key_to_post_meta.each_pair do |url_key, post_meta|
        post_urls << "#{category}/#{url_key}.html"
      end
    end

    post_urls.each do |url_key|
      entries << SitemapEntry.new(url: url_key, changefreq: 'weekly', priority: 0.3)
    end

    entries
  end
end
