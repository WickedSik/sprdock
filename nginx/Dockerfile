FROM nginx:alpine

MAINTAINER Spring Digital <development@springdigital.nl>

ADD nginx.conf /etc/nginx/

ARG PHP_UPSTREAM=php-fpm

# fix a problem--#397, change application source from dl-cdn.alpinelinux.org to aliyun source.
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash \
    && rm /etc/nginx/conf.d/default.conf \
    && echo "upstream php-upstream { server ${PHP_UPSTREAM}:9000; }" > /etc/nginx/conf.d/upstream.conf

CMD ["nginx"]

EXPOSE 80 443
