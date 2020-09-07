FROM alpine:latest

ENV TZ="Asia/Shanghai"

RUN apk --no-cache add tzdata mysql mysql-client redis aria2 \
    && cp /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && mkdir -p /run/mysqld \
    && chown mysql:mysql /run/mysqld \
    && echo "include /etc/redis-cloudreve.conf" >> /etc/redis.conf


COPY --from=xavierniu/cloudreve:latest /cloudreve/cloudreve-main /usr/bin/cloudreve
COPY cloudreve.ini /etc/cloudreve.ini.tpl
COPY cloudreve-ssl.ini /etc/cloudreve-ssl.ini.tpl
COPY mysql-init.sql /etc/mysql-init.sql
COPY redis-cloudreve.conf /etc/redis-cloudreve.conf
COPY --from=ochinchina/supervisord:latest /usr/local/bin/supervisord /usr/bin/supervisord
COPY supervisor.conf /etc/supervisor.conf
COPY entrypoint.sh /entrypoint.sh

EXPOSE 80
EXPOSE 443
VOLUME /cloudreve

ENTRYPOINT /entrypoint.sh
