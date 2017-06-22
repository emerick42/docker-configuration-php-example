FROM mysql:5.6

MAINTAINER Morgan BRUNOT <brunot.morgan@gmail.com>

ADD config/my.cnf /etc/mysql/

ADD base.sql /docker-entrypoint-initdb.d/
