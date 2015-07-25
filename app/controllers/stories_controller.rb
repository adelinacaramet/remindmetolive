class StoriesController < BasicAuthController

  def index
    @post_metas = PostMeta.published_for_category 'stories'
  end
end
