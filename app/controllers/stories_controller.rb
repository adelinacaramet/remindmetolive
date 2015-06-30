class StoriesController < ApplicationController

  def index
    @post_metas = PostMeta.published_for_category 'stories'
  end
end
