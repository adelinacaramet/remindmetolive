FactoryGirl.define do
  factory :post_meta do
    title 'Cristi and Adela Wedding'
    picture_url 'https://farm4.staticflickr.com/3940/15084169773_53497cc18a_n.jpg'
    url '/stories/cristi-and-adela-wedding.html'
    description 'The best wedding ever'
    url_key 'cristi-and-adela-wedding'
    post_file_name '2015-02-03-cristi-and-adela-wedding.slim'
    tags ['wedding', 'ceremony', 'fun']
    category 'stories'
    keywords 'fun, wedding'
    status 'published'
    layout 'post'
  end
end
