require 'rails_helper'

RSpec.describe Story, :type => :model do

  context '#get_by_url_key' do
    url_key = 'cristi-and-adela-wedding'

    subject { Story.get_by_url_key url_key }

    it 'should return a story' do
      is_expected.not_to be_nil
    end

    describe 'meta' do
      let(:meta) { subject.story_meta.attributes }

      it 'should return a meta' do
       expect(meta).not_to be_nil
      end

      it 'should have the right title' do
        expect(meta[:title]).to eq 'Cristi And Adela Wedding'
      end

      it 'should have the right url_key' do
        expect(meta[:url_key]).to eq 'cristi-and-adela-wedding'
      end

      it 'should have the right description' do
        expect(meta[:description]).to eq 'seo description'
      end

      it 'should have the right picture_url' do
        expect(meta[:picture_url]).to eq 'https://farm4.staticflickr.com/3940/15084169773_53497cc18a_n.jpg'
      end

      it 'should have the right tags' do
        expect(meta[:tags]).to eq 'weddding, ceremony, travel'
      end

      it 'should have the right keywords' do
        expect(meta[:keywords]).to eq 'wedding'
      end
    end

    describe 'html' do
      let(:html) {subject.html}

      it 'should return a html' do
        expect(html).not_to be_nil
      end

      it "should have the correct html" do
        story_path = Rails.root.join('stories', "#{url_key}.slim").to_s
        slim_template = Slim::Template.new(story_path)
        story_html = slim_template.render(self)

        expect(html).to eq story_html
      end
      
    end
  end
end
