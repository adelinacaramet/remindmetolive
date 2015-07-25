class SitemapEntry
  include Virtus.model

  attribute :url, String
  attribute :changefreq, String
  attribute :priority, Float
end
