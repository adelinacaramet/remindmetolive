== README

## Rake tasks:

    rake sitemap:refresh

## Docker

    boot2docker start
    boot2docker shellinit
    docker build -t danpersa/remindmetolive:v1 .
    docker run -p 80:80 danpersa/remindmetolive:v1
    docker run -i -p 80:80 -t danpersa/remindmetolive:devel /bin/bash

    docker exec -t -i YOUR-CONTAINER-ID bash -l

    passenger-status
    passenger-memory-stats

    boot2docker ip

    docker push danpersa/remindmetolive
    docker pull danpersa/remindmetolive:v2

### Docker Redeploy

    docker pull danpersa/remindmetolive:v2
    docker ps
    docker kill <container id>
    docker run -p 80:80 danpersa/remindmetolive:v1
