require 'rails_helper'

RSpec.describe Story, :type => :model do

  before do 
    story_meta = build(:story_meta)
    allow(StoryMeta).to receive(:parse_meta_file).and_return(story_meta)
  end

  context '#get_all' do

    subject { StoryMeta.get_all }

    it 'should contain' do
      expect(subject.first.attributes).to eq title: "Cristi and Adela Wedding",
                                             picture_url: 'https://farm4.staticflickr.com/3940/15084169773_53497cc18a_n.jpg',
                                             url: '/stories/cristi-and-adela-wedding.html',
                                             description: 'description',
                                             url_key: 'cristi-and-adela-wedding',
                                             tags: 'wedding, fun',
                                             keywords: 'fun, wedding'
    end
  end

  context '#create_story_metas' do

    subject { StoryMeta.create_story_metas [ '/stories/story.meta' ] }

    it 'should have at least one story meta' do
      is_expected.not_to be_empty
    end

    it 'should have exactly 1 story meta' do
      expect(subject.size).to eq(1)
    end 
  end

  context '#get_story_meta_paths' do

    subject { StoryMeta.get_story_meta_paths }

    it 'should return story meta paths' do
      is_expected.not_to be_empty
    end
  end
end