# Production Django Docker Config

**Blog: https://medium.com/@endalk200/production-ready-docker-configuration-with-digitalocean-container-registry-part-i-e53ea56b4be1**

subscribe [here](https://medium.com/subscribe/@endalk200) for more article

This project is to document production-ready Docker setup. Please note that Django application is rudimentary and not fit for production.

This project present docker setup of four component of a typical Django application i.e. web server, celery worker, celery beat and celery monitoring using flower.

## Docker Setup

Detailed documentation of Docker setup can be found in above blog.
It discusses in detail `Dockerfile`, `entrypoint.sh` and `start.sh`

#### Useful Commands

To be run from root of the project.

1. Start all containers including essential services(PostgreSQL and Redis):  `docker-compose up`

2. Stop all containers: `docker-compose down`

## Django application details

The Django application has a simple view `dockerapp/core/views.py` linked to url `/task-trigger/`, which picks a random integer between 1 and 100 and send to celery task(defined in `dockerapp/core/tasks.py`) which count next five integer at interval of one second.


## Development

This is a work in progress, hence further enhancements in all aspects of Docker in this project is expected. Any advice regarding improvement of Docker aspect is welcome and encouraged.

For detailed discussion please refer to corresponding blog https://medium.com/@endalk200/production-ready-docker-configuration-with-digitalocean-container-registry-part-i-e53ea56b4be1

**Use the following link to get 100 USD in DigitalOcean free credit**

[![DigitalOcean Referral Badge](https://web-platforms.sfo2.cdn.digitaloceanspaces.com/WWW/Badge%201.svg)](https://www.digitalocean.com/?refcode=7a5167a14566&utm_campaign=Referral_Invite&utm_medium=Referral_Program&utm_source=badge)