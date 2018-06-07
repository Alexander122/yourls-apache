#!/bin/bash
set -euo pipefail

if [ ! -e /var/www/yourls/yourls-loader.php ]; then
	tar cf - --one-file-system -C /var/www/yourls . | tar xf -
	chown -R www-data:www-data /var/www/html
fi

# if not specified, let's use the default
: "${YOURLS_DB_USER:=mysql}"
if [ "$YOURLS_DB_USER" = 'root' ]; then
    : "${YOURLS_DB_PASS:=${MYSQL_ENV_MYSQL_ROOT_PASSWORD:-}}"
else
    : "${YOURLS_DB_PASS:=${MYSQL_ENV_MYSQL_PASSWORD:-}}"
fi
: "${YOURLS_DB_NAME:=yourls}"
# if not specified, let's generate a random value
: "${YOURLS_COOKIEKEY:=$(head -c1m /dev/urandom | sha1sum | cut -d' ' -f1)}"

if [ ! -e /var/www/yourls/user/config.php ]; then
    cp /var/www/yourls/config-docker.php /var/www/yourls/user/config.php
    chown www-data:www-data /var/www/yourls/user/config.php
fi

: "${YOURLS_USER:=}"
: "${YOURLS_PASS:=}"
if [ "${YOURLS_USER}" -a "${YOURLS_PASS}" ]; then
    sed -i "s/  getenv('YOURLS_USER') => getenv('YOURLS_PASS'),/  '${YOURLS_USER}' => '${YOURLS_PASS}',/g" /var/www/yourls/user/config.php
fi

exec "$@"