class CategoriesController < ApplicationController

  def stories
    @post_metas = PostMeta.get_published_for_category 'stories'
  end

  def cats
    @post_metas = PostMeta.get_published_for_category 'cats'
  end
end
