require 'rails_helper'

RSpec.describe Post, :type => :model do

  before do
    ActionController::Base.perform_caching = false
    post_meta = build(:post_meta)
    allow(PostMeta).to receive(:parse_meta_file).and_return(post_meta)
  end

  context '#get_all' do

    subject { PostMeta.get_all }

    it 'should contain' do
      expect(subject.first.attributes).to eq title: "Cristi and Adela Wedding",
                                             picture_url: 'https://farm4.staticflickr.com/3940/15084169773_53497cc18a_n.jpg',
                                             url: '/stories/cristi-and-adela-wedding.html',
                                             description: 'The best wedding ever',
                                             url_key: 'cristi-and-adela-wedding',
                                             post_file_name: '2015-02-03-cristi-and-adela-wedding.slim',
                                             tags: ['wedding', 'ceremony', 'fun'],
                                             keywords: 'fun, wedding',
                                             category: 'Wedding',
                                             status: 'published'
    end
  end

  context '#get_published' do
    before do
      post_metas = [build(:post_meta, status: 'draft'), build(:post_meta, title: 'Published Story', status: 'published')]
      allow(PostMeta).to receive(:get_all).and_return(post_metas)
    end

    subject { PostMeta.get_published }

    it 'should return one post meta' do
      expect(subject.size).to eq 1
    end

    it 'should return the correct post meta' do
      expect(subject.first.title).to eq 'Published Story'
    end
  end

  context '#create_post_metas' do

    subject { PostMeta.create_post_metas [ '/posts/post.meta' ] }

    it 'should have at least one post meta' do
      is_expected.not_to be_empty
    end

    it 'should have exactly 1 post meta' do
      expect(subject.size).to eq 1
    end
  end

  context '#get_post_meta_paths' do

    subject { PostMeta.get_post_meta_paths }

    it 'should return post meta paths' do
      is_expected.not_to be_empty
    end
  end

  context '#extract_tags' do
    describe 'more tags' do
      subject { PostMeta.extract_tags 'travel ,  wedding  '}

      it 'should return an array of 2 tags' do
        expect(subject).to eq(['travel', 'wedding'])
      end
    end

    describe 'no tags' do
      subject { PostMeta.extract_tags '   '}

      it 'should return an empty array' do
        expect(subject).to be_empty
      end
    end

    describe 'one tag' do
      subject { PostMeta.extract_tags ' travel '}

      it 'should return an array with one element' do
        expect(subject).to eq(['travel'])
      end
    end
  end

  context '#extract_category' do
    describe 'more tags' do
      subject { PostMeta.extract_category [' travel ', 'wedding']}

      it 'should return the correct category' do
        expect(subject).to eq('Travel')
      end
    end

    describe 'no tags' do
      subject { PostMeta.extract_category []}

      it 'should return an empty string' do
        expect(subject).to be_empty
      end
    end
  end
end
