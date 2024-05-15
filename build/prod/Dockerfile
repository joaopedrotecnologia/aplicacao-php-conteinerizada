from public.ecr.aws/docker/library/php:8.2.13-fpm-alpine3.18

ENV DOCUMENT_ROOT /var/www/localhost/htdocs
ENV TZ=America/Sao_Paulo

#Libs do SO
RUN apk add --no-cache \
    $PHPSIZE_DEPS \
    nginx \
    pkgconfig \
    openssl-dev \
    librdkafka-dev \
    autoconf \
    && apk del --no-cache \
    perl \
    dpkg-dev \
    file \
    re2c
    

RUN apk del make musl-dev libcx-dev gcc g++ autoconf

WORKDIR $DOCUMENT_ROOT

run RM -f /etc/nginx/conf.d/*

COPY . $DOCUMENT_ROOT
COPY .setup/build/prod/nginx.conf /etc/nginx/nginx.conf
COPY .setup/build/prod/php/php.ini /usr/local/etc/php/conf.d/app.ini
COPY .setup/build/prod/nginx.conf /usr/local/etc/php/php-fpm.d/www.conf

COPY --from public.ecr.aws/m8n7w3l2/fretehub:composer-2.5.5 /usr/bin/composer /usr/local/bin/composer

RUN composer install --no-dev --no-iteraction --optimize-autoloader --no-scripts

RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
RUN chmod +x .setup/build/scripts/entrypoint.sh
ENTRYPOINT [".setup/build/scripts/entrypoint.sh"]
