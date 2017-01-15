# README

[![Build Status](https://travis-ci.org/adelinacaramet/remindmetolive.svg?branch=master)](https://travis-ci.org/adelinacaramet/remindmetolive)

## Rake tasks:

    rake sitemap:refresh

    RAILS_ENV=production bundle exec rake assets:precompile --trace

## Start in production mode

    RAILS_ENV=production rails s -e production

## Docker

    docker-machine start default
    make

    docker run -i -p 80:80 -t danpersa/remindmetolive:latest /bin/bash
    docker exec -t -i YOUR-CONTAINER-ID bash -l

    passenger-status
    passenger-memory-stats

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

## Profiling

For profiling we are using [Rack Mini Profiler](https://github.com/MiniProfiler/rack-mini-profiler)
We are using [flamegraph](https://github.com/SamSaffron/flamegraph) also

In development mode the profiler data will appear in the upper left corner
Click on the number for more information
For a flamegraph, use `?pp=flamegraph` in the urls
