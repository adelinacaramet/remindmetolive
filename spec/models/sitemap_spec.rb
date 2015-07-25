require 'rails_helper'

RSpec.describe Sitemap, :type => :model do
  describe 'generate a Sitemap' do

    let(:post_meta1) { build(:post_meta, category: 'category1', url_key: 'url_key1') }
    let(:post_meta2) { build(:post_meta, category: 'category2', url_key: 'url_key2') }

    before do
      table = {
        'category1' => {
          'url_key1' => post_meta1
        },
        'category2' => {
          'url_key2' => post_meta2
        }
      }
      allow(PostMeta).to receive(:cached_published_post_metas_table).and_return(table)
    end

    subject { sitemap = Sitemap.generate }

    it 'should have the correct size' do
      expect(subject.entries.size).to eq 7
    end

    it 'should have the correct entries' do
      expect(subject.entries[0].attributes).to eq({ url: '', changefreq: 'daily', priority: 0.9 })
      expect(subject.entries[1].attributes).to eq({ url: 'contact/', changefreq: 'weekly', priority: 0.5 })
      expect(subject.entries[2].attributes).to eq({ url: 'about/', changefreq: 'weekly', priority: 0.5 })
      expect(subject.entries[3].attributes).to eq({ url: 'category1/', changefreq: 'daily', priority: 0.4 })
      expect(subject.entries[4].attributes).to eq({ url: 'category2/', changefreq: 'daily', priority: 0.4 })
      expect(subject.entries[5].attributes).to eq({ url: 'category1/url_key1.html', changefreq: 'weekly', priority: 0.3 })
      expect(subject.entries[6].attributes).to eq({ url: 'category2/url_key2.html', changefreq: 'weekly', priority: 0.3 })
    end
  end
end
