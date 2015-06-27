class StoriesController < ApplicationController

  def index
    @post_metas = PostMeta.get_published
  end

  def show
    url_key = params[:url_key]
    @post = Post.get_published_by_url_key url_key
    puts "post: #{@post}"
    @meta = @post.post_meta
    render layout: 'story'
  end

end
