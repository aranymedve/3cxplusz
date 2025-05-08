FROM amd64/debian:bookworm-slim

# Install necessary packages
RUN apt-get update && apt-get install -y \
    unzip \
    apache2 \
    curl \
    git \
    composer \
    mc \
    php-curl \
    php-bcmath \
    net-tools \
    sshfs \
    openssh-server \
    openssh-client \
    openssl \
    sshpass \
    mariadb-backup \
    wget \
    php-xmlrpc \
    php-gd \
    php-mysql \
    php-xml \
    php-json \
    apt-utils \
    bzip2 \
    links \
    mailutils \
    ssmtp \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/www/html/api
COPY composer.json /var/www/html/api/
WORKDIR /var/www/html/api

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer update
RUN composer install
RUN composer fund

# Set working directory
WORKDIR /var/www/html
