FROM php:7.0-cli

MAINTAINER Emeric KASBARIAN <emeric.kasbarian@gmail.com>

RUN apt-get update && apt-get install -y \
    supervisor

RUN docker-php-ext-install pdo pdo_mysql

# Install redis
RUN pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis

# Enable extension
RUN docker-php-ext-install mbstring \
    && docker-php-ext-enable mbstring \
    && docker-php-ext-install exif \
    && docker-php-ext-enable exif

# Configuration
RUN rm -Rf /etc/php/7.0/cli/php.ini
ADD config/php.ini /etc/php/7.0/cli/php.ini

# Set timezone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
RUN "date"

# Set the locale
RUN apt-get install locales -y
RUN perl -pi -e "s/\# fr_FR\.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/" /etc/locale.gen
RUN /usr/sbin/locale-gen

ADD config/supervisord.conf /etc/supervisord.conf

WORKDIR /var/www/betaseries

CMD ["supervisord", "-c", "/etc/supervisord.conf"]
