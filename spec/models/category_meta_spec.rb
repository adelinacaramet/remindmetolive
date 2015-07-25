require 'rails_helper'

RSpec.describe CategoryMeta, :type => :model do

  before do
    category_meta = build(:category_meta)
    allow(CategoryMeta).to receive(:parse_meta_file).and_return(category_meta)
  end

  context '#for_category' do
    let(:category_to_meta) { { 'stories' => build(:category_meta) } }

    before { expect(CategoryMeta).to receive(:cached_category_to_meta).and_return(category_to_meta) }

    it 'should have the correct title' do
      expect(CategoryMeta.for_category('stories').title).to eq 'Photo Stories'
    end
  end

  context '#cached_category_to_meta' do

    it 'should call the uncached version of the method' do
      expect(CategoryMeta).to receive(:category_to_meta)
      CategoryMeta.cached_category_to_meta
    end
  end

  context '#category_to_meta' do
    before do
      category_metas = [build(:category_meta, title: 'Cats', category: 'cats'), build(:category_meta)]
      expect(CategoryMeta).to receive(:all).and_return(category_metas)
    end

    subject { CategoryMeta.category_to_meta }

    it 'should have 2 metas' do
      expect(subject.size).to eq 2
    end

    it 'should have the correct titles' do
      expect(subject['cats'].title).to eq 'Cats'
      expect(subject['stories'].title).to eq 'Photo Stories'
    end
  end

  context '#all' do
    subject { CategoryMeta.all }

    it 'should contain the correct attributes' do
      expect(subject.first.attributes).to eq title: 'Photo Stories',
                                             description: 'Our photo stories are full of emotions and feelings',
                                             keywords: 'photography, story, photo, stories, visual',
                                             category: 'stories'

    end
  end

  context '#category_meta_paths' do

    subject { CategoryMeta.category_meta_paths }

    it 'should return category meta paths' do
      is_expected.not_to be_empty
    end
  end

  context '#create_category_metas' do

    subject { CategoryMeta.create_category_metas [ '/posts/stories/category.meta' ] }

    it 'should have exactly 1 category meta' do
      expect(subject.size).to eq 1
    end

    it 'should have the correct attributes' do
      expect(subject.first.attributes).to eq title: 'Photo Stories',
                                             description: 'Our photo stories are full of emotions and feelings',
                                             keywords: 'photography, story, photo, stories, visual',
                                             category: 'stories'
    end
  end
end
