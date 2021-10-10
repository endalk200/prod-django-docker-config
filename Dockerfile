
# Step 1- Set arguments used throughout the build
ARG PYTHON_VERSION=3.9-slim-buster
ARG BUILD_ENVIRONMENT=production
ARG APP_HOME=/app 

# Step 2- Set the python base image
FROM python:${PYTHON_VERSION}

# Section 3- Python interpreter flags
ENV PYTHONUNBUFFERED 1 
ENV PYTHONDONTWRITEBYTECODE 1

# Section 4- Compiler and OS libraries
RUN apt-get update && apt-get install --no-install-recommends -y \
    # psycopg2 dependencies
    libpq-dev \
    # Translations dependencies
    gettext \
    # cleaning up unused files
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*

# Section 5- Project libraries and User Creation
COPY requirements.txt /tmp/requirements.txt

RUN pip install --no-cache-dir -r /tmp/requirements.txt \
    && rm -rf /tmp/requirements.txt

RUN useradd -U app_user \
    && install -d -m 0755 -o app_user -g app_user /app/static

# Section 6- Code and User Setup
WORKDIR /app

USER app_user:app_user

COPY --chown=app_user:app_user . .

RUN chmod +x ./*.sh && chmod +x ./postgresql/maintenance/*.sh && chmod +x ./postgresql/maintenance/_sourced/*.sh

# Section 7- Docker Run Checks and Configurations
ENTRYPOINT [ "./entrypoint.sh" ]

CMD [ "./start.sh", "server" ]
