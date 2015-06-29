== README

## Rake tasks:

    rake sitemap:refresh

## Docker

    boot2docker start
    boot2docker shellinit
    docker build -t remindmetolive/site:v1 .
    docker run -p 80:80 remindmetolive/site:v1
    docker run -i -p 80:80 -t remindmetolive/site:devel /bin/bash

    docker exec -t -i YOUR-CONTAINER-ID bash -l

    passenger-status
    passenger-memory-stats

    boot2docker ip

    docker push remindmetolive/site
    docker pull remindmetolive/site
