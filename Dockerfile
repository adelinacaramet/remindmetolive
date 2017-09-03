# Use phusion/passenger-full as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/passenger-docker/blob/master/Changelog.md for
# a list of version numbers.

FROM phusion/passenger-ruby24

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Run Bundle in a cache efficient way
WORKDIR /tmp
ADD Gemfile /tmp/
ADD Gemfile.lock /tmp/
RUN gem install bundler
RUN bundle install

RUN rm -f /etc/service/nginx/down

# Remove the default site
RUN rm /etc/nginx/sites-enabled/default

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD nginx/webapp.conf /etc/nginx/sites-enabled/webapp.conf
ADD nginx/secret_key.conf /etc/nginx/main.d/secret_key.conf
ADD nginx/gzip_max.conf /etc/nginx/conf.d/gzip_max.conf
ADD nginx/00_app_env.conf /etc/nginx/conf.d/00_app_env.conf

EXPOSE 80

USER app
ENV HOME /home/app

# copy the app and give permissions
RUN mkdir /home/app/webapp
COPY . /home/app/webapp
WORKDIR /home/app/webapp
USER root
RUN chown -R app:app /home/app/webapp

# precompile the assets
USER app
RUN RAILS_ENV=production bundle exec rake assets:precompile --trace

USER root
