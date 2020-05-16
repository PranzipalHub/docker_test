FROM php:7.4-fpm

RUN apt-get update \
    && apt-get install -y \
    libpq-dev \
    libpcre3-dev \
    zlib1g-dev \
    libzip-dev \
    curl

RUN pecl install xdebug-2.8.1 \
    && docker-php-ext-enable xdebug

RUN docker-php-ext-install \
    sockets \
    pdo pdo_pgsql \
    bcmath \
    zip \
    opcache

RUN apt-get update \
    && apt-get install -y gettext \
    && apt-get install -y git

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin \
    && php -r "unlink('composer-setup.php');"

COPY devops/php-fpm/99-xdebug.ini.tpl /usr/local/etc/php/conf.d/
COPY devops/php-fpm/boot.sh           /usr/local/bin/php_boot
RUN chmod +x /usr/local/bin/php_boot

COPY . /var/www/html

CMD ["sh", "/usr/local/bin/php_boot"]
