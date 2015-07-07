module ApplicationHelper

  def title
    meta_field :title, 'Visual Stories'
  end

  def description
    meta_field :description, 'Best site'
  end

  def meta_field(field, init = '')
    return init if @meta.nil?
    value = @meta.attributes[field]
    return init if value.nil?
    value
  end

  def publish_day post_meta
    Post.publish_day post_meta
  end

  def publish_month post_meta
    Post.publish_month post_meta
  end
end
