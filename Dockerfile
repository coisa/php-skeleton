FROM php:7.2-alpine
MAINTAINER Felipe Sayão Lobato Abreu <contato@felipeabreu.com.br>

EXPOSE 80

ADD ./ /opt/project
WORKDIR /opt/project

COPY ./ /opt/project

# MySQL dependecies
RUN docker-php-ext-install pdo pdo_mysql

# RabbitMQ dependency
RUN docker-php-ext-install bcmath

# Install Composer
COPY --from=composer:1.6 /usr/bin/composer /usr/bin/composer

# Project dependecies
RUN composer global require hirak/prestissimo \
    ; \
    composer install \
        --no-dev \
        --prefer-dist \
        --optimize-autoloader \
    ; \
    composer clearcache

# Set timezone to America/Sao_Paulo
RUN apk add --update --virtual .build-deps \
        tzdata \
    && \
    cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime \
    && \
    echo "America/Sao_Paulo" > /etc/timezone

# Container Command
CMD ["php", "-S", "0.0.0.0:80", "-t", "/opt/project/public"]

# Logs
VOLUME /opt/project/data/logs

# Cleanup
RUN apk del .build-deps \
    ; \
    rm -rf /var/cache/apk/*
