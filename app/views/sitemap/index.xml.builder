base_url = "http://#{request.host_with_port}"
xml.instruct! :xml, :version=>'1.0'
xml.tag! 'urlset', 'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  @sitemap.entries.each do |entry|
    xml.url {
      xml.loc "http://www.remindmetolive.com/#{entry.url}"
      xml.changefreq entry.changefreq
      xml.priority entry.priority
    }
  end
end
