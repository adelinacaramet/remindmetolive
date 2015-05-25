class StoriesController < ApplicationController

  def index
    @story_metas = StoryMeta.get_published
  end

  def show
    url_key = params[:url_key]
    @story = Story.get_by_url_key url_key
    @meta = @story.story_meta
    render layout: 'story'
  end

end