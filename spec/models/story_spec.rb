require 'rails_helper'

RSpec.describe Story, :type => :model do

  context '#get_published_by_url_key' do
    url_key = 'cristi-and-adela-wedding'

    before do
      story_meta = build(:story_meta)
      allow(StoryMeta).to receive(:get_published_story_meta_by).and_return(story_meta)
    end

    subject { Story.get_published_by_url_key url_key }

    it 'should return a story' do
      is_expected.not_to be_nil
    end

    describe 'meta' do
      let(:meta) { subject.story_meta.attributes }

      it 'should return a meta' do
       expect(meta).not_to be_nil
      end

      it 'should have the right title' do
        expect(meta[:title]).to eq 'Cristi and Adela Wedding'
      end

      it 'should have the right url_key' do
        expect(meta[:url_key]).to eq 'cristi-and-adela-wedding'
      end

      it 'should have the right description' do
        expect(meta[:description]).to eq 'The best wedding ever'
      end

      it 'should have the right picture_url' do
        expect(meta[:picture_url]).to eq 'https://farm4.staticflickr.com/3940/15084169773_53497cc18a_n.jpg'
      end

      it 'should have the right tags' do
        expect(meta[:tags]).to eq ['wedding', 'ceremony', 'fun']
      end

      it 'should have the right keywords' do
        expect(meta[:keywords]).to eq 'fun, wedding'
      end
    end

    describe 'html' do
      let(:html) {subject.html}

      it 'should return a html' do
        expect(html).not_to be_nil
      end
    end
  end
end
