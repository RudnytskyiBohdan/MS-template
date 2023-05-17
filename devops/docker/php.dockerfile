FROM registry.gitlab.com/your-domain/templates/php8.1-fpm:latest
ARG ENV_COMMON_FILE_NAME
ARG ENV_SERVICE_FILE_NAME

WORKDIR /var/www/html

ADD . .

COPY ./devops/conf/php/pool.d/www.conf /etc/php/8.1/fpm/pool.d/www.conf
COPY ./devops/conf/php/php-fpm.conf /etc/php/8.1/fpm/php-fpm.conf
COPY ./devops/conf/php/php.ini /etc/php/8.1/fpm/php.ini

RUN cat $ENV_COMMON_FILE_NAME > .env && echo >> .env && cat $ENV_SERVICE_FILE_NAME >> .env && \
    rm -fr env && \
    mkdir -p log var/cache/stage var/cache/prod && \
    find . -type f -name "*.sh" -exec chmod +x "{}" \; && \
    composer install && php bin/console assets:install && chown -R www-data:www-data ./

CMD ["php-fpm8.1", "-F"]
