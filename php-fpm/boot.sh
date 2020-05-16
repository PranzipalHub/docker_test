#!/usr/bin/env bash

/usr/local/bin/composer.phar install -d /var/www/html
/usr/local/bin/composer.phar dump-autoload -d /var/www/html

vars='\$REMOTE_DEBUG_HOST \$REMOTE_DEBUG_PORT'

export REMOTE_DEBUG_HOST=${REMOTE_DEBUG_HOST} \
       REMOTE_DEBUG_PORT=${REMOTE_DEBUG_PORT}

envsubst "$vars" < "/usr/local/etc/php/conf.d/99-xdebug.ini.tpl" > "/usr/local/etc/php/conf.d/99-xdebug.ini"

php /var/www/html/artisan migrate
php /var/www/html/artisan cache:clear

php-fpm --allow-to-run-as-root
