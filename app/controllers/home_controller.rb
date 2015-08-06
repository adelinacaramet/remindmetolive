class HomeController < BasicAuthController

  @@default_title = 'Remindmetolive - Photos and Stories'
  @@default_keywords = 'photography, photos, story, stories, photographs, narratives, share, human, street, travel, cats'

  @@index_meta ||= PostMeta.new title: "#{@@default_title}",
                                description: 'At Remindmetolive, we combine photography with storytelling. Let us help you shape and share your story with the world!',
                                keywords: "#{@@default_keywords}"

  @@contact_meta ||= PostMeta.new title: "#{@@default_title} - Contact Us",
                                description: 'Contact the Remindmetolive team. Let us help you shape and share your story with the world!',
                                keywords: "contact, #{@@default_keywords}"

  @@about_meta ||= PostMeta.new title: "#{@@default_title} - About Us",
                                description: 'We started the Remindmetolive project to share stories of people and places through photography. Let us help you shape and share your story with the world!',
                                keywords: "about, #{@@default_keywords}"
  def index
    @meta = @@index_meta
  end

  def contact
    @meta = @@contact_meta
  end

  def about
    @meta = @@about_meta
  end

  def send_contact
    ContactMailer.contact(params[:contact][:name], params[:contact][:email], params[:contact][:subject], params[:contact][:message]).deliver_now
  end
end
