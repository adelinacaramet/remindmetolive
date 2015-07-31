require 'rails_helper'

class UrlHelperClass
  include UrlHelper
end

url_helper = UrlHelperClass.new

RSpec.describe UrlHelper, :type => :helper do

  context '#image_url' do
    subject { url_helper.image_url 'image.jpg', path}

    describe 'when the path is not provided' do
      let(:path) { '' }

      it 'should return the correct url for development' do
        expect(subject).to eq '/images/image.jpg'
      end
    end

    describe 'when the path is provided' do
      let(:path) { '2015-03-03-cats' }

      it 'should return the correct url for development' do
        expect(subject).to eq '/images/2015-03-03-cats/image.jpg'
      end
    end
  end
end
