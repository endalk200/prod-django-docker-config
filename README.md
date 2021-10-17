# Production Django Docker Config

For detailed explanation read the full blog.

- [Production-Ready Docker Configuration With DigitalOcean Container Registry Part I](https://endalk200.medium.com/production-ready-docker-configuration-with-digitalocean-container-registry-part-i-e53ea56b4be1)
- [Production-Ready Docker Configuration With DigitalOcean Container Registry Part II](https://endalk200.medium.com/production-ready-docker-configuration-with-digitalocean-container-registry-part-ii-5361b8e6d5e0)

[subscribe](https://medium.com/subscribe/@endalk200) for more articles like this.

This project is to document production-ready Docker setup. Please note that Django application is rudimentary and not fit for production.

This project present docker setup of four component of a typical Django application i.e. 

- web server
- `celery worker`
- `celery beat` and 
- `celery monitoring` using `flower`.

## Docker Setup

Detailed documentation of Docker setup can be found in above blog.
It discusses in detail `Dockerfile`, for both the web server and postgresql `entrypoint.sh`, `start.sh`, `backup.sh` and `restore.sh`

### Useful Commands

To be run from root of the project. Before you run your docker containers rename the `.env_copy` file to `.env`. The docker compose file loads environment variables from that file.

1. To start all containers including essential services(PostgreSQL and Redis):  `docker-compose up`

2. Stop all containers: `docker-compose down`

3. To backup all the data in the database to the container itself `docker-compose exec postgres backup` **NOTE:** The backup is not stored locally.

4. To list all existing backups `docker-compose exec postgres backups`

5. To copy the backup file from the container to your local machine, First run `docker ps` and grab the container ID of your postgresql container then run `docker cp 9c5c3f055843:/backups ./backups` this will copy all your database backups to your `/backups` directory locally.

6. If you want to automate the backup process you can grab the container ID of your postgresql db and backup as follows `docker cp $(docker-compose ps -q postgres):/backups ./backups`

7. To restore your backup `docker-compose exec postgres restore backup_2021_03_13T09_05_07.sql.gz`. Assuming your backup filename is `backup_2021_03_13T09_05_07.sql.gz`

## Django application details

The Django application has a simple view `dockerapp/core/views.py` linked to url `/task-trigger/`, which picks a random integer between 1 and 100 and send to celery task(defined in `dockerapp/core/tasks.py`) which count next five integer at interval of one second.

## Development

This is a work in progress, hence further enhancements in all aspects of Docker in this project is expected. Any advice regarding improvement of Docker aspect is welcome and encouraged.

For detailed discussion please refer to corresponding blog 

**Use the following link to get 100 USD in DigitalOcean free credit**

[![DigitalOcean Referral Badge](https://web-platforms.sfo2.cdn.digitaloceanspaces.com/WWW/Badge%201.svg)](https://www.digitalocean.com/?refcode=7a5167a14566&utm_campaign=Referral_Invite&utm_medium=Referral_Program&utm_source=badge)