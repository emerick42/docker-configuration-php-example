# nginx/Dockerfile
FROM debian:jessie

MAINTAINER Morgan BRUNOT <brunot.morgan@gmail.com>

RUN apt-get update && apt-get install -y \
    nginx

ADD config/nginx.conf /etc/nginx/
ADD config/betaseries.conf /etc/nginx/sites-available/
ADD config/vhost /etc/nginx/
ADD config/vhost_dirs /etc/nginx/
ADD config/vhost_expires /etc/nginx/
ADD config/fastcgi_params /etc/nginx/

RUN ln -s /etc/nginx/sites-available/my_project.conf /etc/nginx/sites-enabled/my_project
RUN rm /etc/nginx/sites-enabled/default

RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf

RUN usermod -u 1000 www-data

CMD ["nginx"]

EXPOSE 80
EXPOSE 443
