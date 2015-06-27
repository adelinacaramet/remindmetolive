class PostsController < ApplicationController

  def show
    category = params[:category]
    url_key = params[:url_key]
    @post = Post.get_published_by category, url_key
    if @post.nil?
      render :status => 404
      return
    end
    @meta = @post.post_meta
    render layout: 'post'
  end
end
