class CategoriesController < ApplicationController

  def stories
    @post_metas = PostMeta.published_for_category 'stories'
  end

  def cats
    @post_metas = PostMeta.published_for_category 'cats'
  end

  def streets_of_berlin
    @post_metas = PostMeta.published_for_category 'streets-of-berlin'
  end

  def categories
    @categories = PostMeta.categories
  end
end
