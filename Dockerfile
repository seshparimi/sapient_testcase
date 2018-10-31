FROM alpine:3.5 As build
MAINTAINER  Sesh Parimi <seshparimi@yahoo.co.uk>

WORKDIR /build

RUN apk --update add wget \ 
    nginx \
    supervisor \
    bash \
    curl \
    git \
    php5-fpm \
    mkdir -p /etc/nginx            && \
    mkdir -p /var/www/app          && \
    mkdir -p /run/nginx            && \
    mkdir -p /var/log/supervisor   && \
    rm /etc/nginx/nginx.conf
ADD ./nginx.conf /etc/nginx/nginx.conf
ADD ./supervisord.conf /etc/supervisord.conf
ADD ./start.sh /start.sh

# Expose Ports
EXPOSE 443 80

 #Start Supervisord
CMD ["/bin/sh", "/start.sh"]

# Run container
FROM build As release



