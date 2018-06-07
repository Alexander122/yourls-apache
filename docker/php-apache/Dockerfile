FROM php:5-apache
WORKDIR "/var/www"

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# PHP extensions
RUN apt-get update && apt-get install -y \
        zlib1g-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
    && pecl install xdebug-2.2.7 \
    && docker-php-ext-install -j$(nproc) mbstring pdo_mysql tokenizer mcrypt iconv mysqli \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-enable xdebug \
    && docker-php-ext-install zip
 
# Apache modules
RUN a2enmod rewrite

VOLUME /var/www

ENV YOURLS_VERSION 1.7.2

CMD set -ex; \
	curl -o yourls.tar.gz -SL "https://github.com/YOURLS/YOURLS/archive/${YOURLS_VERSION}.tar.gz"; \
	tar -xzf yourls.tar.gz -C /usr/src/; \
	mv -R "/usr/src/YOURLS-${YOURLS_VERSION}/" /var/www; \
	rm yourls.tar.gz;
	
#COPY "/usr/src/YOURLS-${YOURLS_VERSION}" /var/www

COPY config.php /var/www/html/user

CMD ["apache2-foreground"]