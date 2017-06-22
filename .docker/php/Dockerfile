FROM php:7.0-fpm

MAINTAINER Morgan BRUNOT <brunot.morgan@gmail.com>

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libmagickwand-dev \
    mysql-client

RUN docker-php-ext-install pdo pdo_mysql soap
RUN docker-php-ext-install zip

# Install redis
RUN pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis

# Install imagick
RUN pecl install imagick-3.4.1 \
    && docker-php-ext-enable imagick

# Enable extension
RUN docker-php-ext-install mbstring \
    && docker-php-ext-enable mbstring \
    && docker-php-ext-install exif \
    && docker-php-ext-enable exif

# Configuration
RUN rm -Rf /etc/php/7.0/cli/php.ini
RUN rm -Rf /etc/php/7.0/fpm/php.ini
ADD config/php.ini /etc/php/7.0/cli/php.ini
ADD config/php.ini /etc/php/7.0/fpm/php.ini

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version

# Set timezone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
RUN "date"

# Set the locale
RUN apt-get install locales -y
RUN perl -pi -e "s/\# fr_FR\.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/" /etc/locale.gen
RUN /usr/sbin/locale-gen

# Enable blackfire
RUN version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/$version \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so \
    && printf "extension=blackfire.so\nblackfire.agent_socket=tcp://blackfire:8707\n" > $PHP_INI_DIR/conf.d/blackfire.ini

WORKDIR /var/www/my_project
