require 'rails_helper'

RSpec.describe Post, :type => :model do

  before do
    post_meta = build(:post_meta)
    allow(PostMeta).to receive(:parse_meta_file).and_return(post_meta)
  end

  context '#categories' do

    subject { PostMeta.categories }

    describe 'when we have the default categories' do

      it 'should contain the correct number of categories' do
        expect(subject.size).to eq 1
      end

      it 'should contain the correct category' do
        expect(subject.first).to eq 'stories'
      end
    end
  end

  context '#published_post_meta_by' do

    describe 'when using a valid category' do
      subject { PostMeta.published_post_meta_by 'stories', 'cristi-and-adela-wedding' }

      it 'should return the correct map of url_key to post metas' do
        expect(subject.attributes).to eq build(:post_meta).attributes
      end
    end

    describe 'when giving a missing category' do
      subject { PostMeta.published_post_meta_by 'nonexisting', 'cristi-and-adela-wedding' }

      it 'should return nil' do
        expect(subject).to be_nil
      end
    end

    describe 'when giving a missing url_key' do
      subject { PostMeta.published_post_meta_by 'stories', 'nonexisting' }
      it 'should return nil' do
        expect(subject).to be_nil
      end
    end
  end

  context '#get_all' do

    subject { PostMeta.get_all }

    it 'should contain the correct attributes' do
      expect(subject.first.attributes).to eq title: "Cristi and Adela Wedding",
                                             picture_url: 'https://farm4.staticflickr.com/3940/15084169773_53497cc18a_n.jpg',
                                             url: '/stories/cristi-and-adela-wedding.html',
                                             description: 'The best wedding ever',
                                             url_key: 'cristi-and-adela-wedding',
                                             post_file_name: '2015-02-03-cristi-and-adela-wedding.slim',
                                             tags: ['wedding', 'ceremony', 'fun'],
                                             keywords: 'fun, wedding',
                                             category: 'stories',
                                             status: 'published',
                                             layout: 'post'
    end
  end

  context '#all_published' do
    before do
      post_metas = [build(:post_meta, status: 'draft'), build(:post_meta, title: 'Published Story', status: 'published')]
      allow(PostMeta).to receive(:get_all).and_return(post_metas)
    end

    subject { PostMeta.all_published }

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

  context '#post_meta_paths' do

    subject { PostMeta.post_meta_paths }

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
end
