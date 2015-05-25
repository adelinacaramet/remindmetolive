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
                                             tags: ['wedding', 'fun'],
                                             keywords: 'fun, wedding',
                                             category: 'Wedding',
                                             status: 'published'
    end
  end

  context '#get_published' do
    before do
      story_metas = [build(:story_meta, status: 'draft'), build(:story_meta, title: 'Published Story', status: 'published')]
      allow(StoryMeta).to receive(:get_all).and_return(story_metas)
    end

    subject { StoryMeta.get_published }

    it 'should return one story meta' do
      expect(subject.size).to eq 1
    end

    it 'should return the correct story meta' do
      expect(subject.first.title).to eq 'Published Story'
    end
  end

  context '#create_story_metas' do

    subject { StoryMeta.create_story_metas [ '/stories/story.meta' ] }

    it 'should have at least one story meta' do
      is_expected.not_to be_empty
    end

    it 'should have exactly 1 story meta' do
      expect(subject.size).to eq 1
    end 
  end

  context '#get_story_meta_paths' do

    subject { StoryMeta.get_story_meta_paths }

    it 'should return story meta paths' do
      is_expected.not_to be_empty
    end
  end

  context '#extract_tags' do
    describe 'more tags' do
      subject { StoryMeta.extract_tags 'travel ,  wedding  '}

      it 'should return an array of 2 tags' do
        expect(subject).to eq(['travel', 'wedding'])
      end
    end

    describe 'no tags' do
      subject { StoryMeta.extract_tags '   '}
      
      it 'should return an empty array' do
        expect(subject).to be_empty
      end
    end

    describe 'one tag' do
      subject { StoryMeta.extract_tags ' travel '}
      
      it 'should return an array with one element' do
        expect(subject).to eq(['travel'])
      end
    end
  end

  context '#extract_category' do
    describe 'more tags' do
      subject { StoryMeta.extract_category [' travel ', 'wedding']}

      it 'should return the correct category' do
        expect(subject).to eq('Travel')
      end
    end

    describe 'no tags' do
      subject { StoryMeta.extract_category []}
      
      it 'should return an empty string' do
        expect(subject).to be_empty
      end
    end 
  end
end