source 'https://rubygems.org'
ruby '2.4.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.9'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'slim-rails'
gem 'virtus'

#gem 'debug_inspector'
#gem 'binding_of_caller'

# profiler
gem 'rack-mini-profiler', require: false
gem 'flamegraph'
# monitoring
gem 'newrelic_rpm'
gem 'stackprof'

group :development, :test do
  gem 'rspec-rails', '~> 3.0'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'factory_girl_rails'

  # these 3 gems are for faster testing
  gem 'spring-commands-rspec'
  gem 'guard-rspec'
  gem 'rb-fsevent' if `uname` =~ /Darwin/
  gem 'therubyracer'
  gem 'tzinfo-data'
end

# Access an IRB console on exception pages or by using <%= console %> in views
gem 'web-console', group: :development

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
