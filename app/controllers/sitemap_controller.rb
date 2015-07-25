class SitemapController < ApplicationController

  def index
    @sitemap = Sitemap.generate
  end
end
