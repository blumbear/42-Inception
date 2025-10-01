FROM alpine:3.16
ARG PHP_VERSION=8
RUN apk update && apk upgrade && apk add --no-cache \
    php${PHP_VERSION} php${PHP_VERSION}-fpm php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-json php${PHP_VERSION}-curl php${PHP_VERSION}-dom \
    php${PHP_VERSION}-exif php${PHP_VERSION}-fileinfo php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-openssl php${PHP_VERSION}-xml php${PHP_VERSION}-zip \
    php${PHP_VERSION}-redis wget unzip bash openssl

WORKDIR /var/www
# On garde un WordPress "cache" dans l'image (copié ensuite si volume vide)
RUN wget -q https://wordpress.org/latest.zip && \
    unzip -q latest.zip && mv wordpress /wp-cache && rm -f latest.zip && \
    chmod -R 0775 /wp-cache/wp-content

COPY ./requirements/wordpress/conf/wp-config-create.sh /usr/local/bin/wp-config-create.sh
COPY ./requirements/wordpress/tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /usr/local/bin/wp-config-create.sh /entrypoint.sh && \
    sed -i 's|^listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|' /etc/php8/php-fpm.d/www.conf

EXPOSE 9000
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/php-fpm8","-F"]