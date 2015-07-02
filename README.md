== README

## Rake tasks:

    rake sitemap:refresh

    RAILS_ENV=production bundle exec rake assets:precompile --trace

## Start in production mode

    RAILS_ENV=production rails s -e production

## Docker

    boot2docker start
    boot2docker shellinit
    docker build -t danpersa/remindmetolive:latest .
    docker run -p 80:80 danpersa/remindmetolive:latest
    docker run -i -p 80:80 -t danpersa/remindmetolive:latest /bin/bash

    docker exec -t -i YOUR-CONTAINER-ID bash -l

    passenger-status
    passenger-memory-stats

    boot2docker ip

    docker push danpersa/remindmetolive
    docker pull danpersa/remindmetolive:latest

### Docker Redeploy

    docker pull danpersa/remindmetolive:latest
    docker ps
    docker kill <container id>
    docker run -p 80:80 danpersa/remindmetolive:latest


## Testing

For faster tests:

    spring binstub --all
    spring status
    guard

The tests will run automatically as soon as you change a file

[This](http://girders.org/blog/2014/02/06/setup-rails-41-spring-rspec-and-guard/) article was really helpful on setting this up.
