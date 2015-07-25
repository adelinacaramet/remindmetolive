require 'rails_helper'

RSpec.describe SitemapEntry, :type => :model do
  describe 'create a SitemapEntry' do
    subject { sitemap_entry = SitemapEntry.new(url: '/contact', changefreq: 'daily', priority: 0.9) }

    it 'should have the correct attributes' do
      expect(subject.url).to eq '/contact'
      expect(subject.changefreq).to eq 'daily'
      expect(subject.priority).to eq 0.9
    end
  end
end
