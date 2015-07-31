class CategoriesController < BasicAuthController

  include UrlHelper

  def stories
    @post_metas = PostMeta.published_for_category 'stories'
    @meta = CategoryMeta.for_category 'stories'
  end

  def cats
    @post_metas = PostMeta.published_for_category 'cats'
    @meta = CategoryMeta.for_category 'cats'
  end

  def streets_of_berlin
    @post_metas = PostMeta.published_for_category 'streets-of-berlin'
    @meta = CategoryMeta.for_category 'streets-of-berlin'
  end

  def categories
    @categories = PostMeta.categories
  end
end
