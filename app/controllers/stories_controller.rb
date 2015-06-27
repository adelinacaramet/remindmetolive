class StoriesController < ApplicationController

  def index
    @post_metas = PostMeta.get_published_for_category 'stories'
  end
end
