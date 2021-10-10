# Step 1- Set arguments used throughout the build
# ARG POSTGRES_VERSION=13.3-alpine
ARG POSTGRES_VERSION=latest

# Step 2- Set the postgresql base image
FROM postgres:${POSTGRES_VERSION}

# Step 3- Copy Postgresql configuration files and maintainance scripts
COPY ./postgresql/maintenance /usr/local/bin/maintenance

RUN chmod +x /usr/local/bin/maintenance/*

RUN mv /usr/local/bin/maintenance/* /usr/local/bin \
    && rmdir /usr/local/bin/maintenance