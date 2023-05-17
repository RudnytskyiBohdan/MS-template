FROM registry.gitlab.com/your-domain/templates/nginx:latest
ARG BACKEND_ARRD_PORT
ARG DOMAIN

RUN cp /usr/share/zoneinfo/Etc/GMT+4 /etc/localtime

WORKDIR /var/www/html

ADD . .

COPY devops/conf/nginx/nginx.conf /etc/nginx/nginx.conf
COPY devops/conf/nginx/conf.d /etc/nginx/conf.d

RUN rm -fr env && \
    sed -i "s/BACKEND_ARRD_PORT/$BACKEND_ARRD_PORT/g;s/DOMAIN/$DOMAIN/g" /etc/nginx/conf.d/default.conf && \
    chown -R www-data:www-data ./
