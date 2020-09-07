#!/usr/bin/env sh

if [ ! -d /cloudreve/mysql ]; then
  mkdir -p /cloudreve/mysql
  chown mysql:mysql /cloudreve/mysql
fi

if [ ! -d /cloudreve/redis ]; then
  mkdir -p /cloudreve/redis
fi

if [ ! -d /cloudreve/downloads ]; then
  mkdir -p /cloudreve/downloads
fi

if [ ! -d /cloudreve/uploads ]; then
  mkdir -p /cloudreve/uploads
fi

if [ ! -d /cloudreve/cert ]; then
  mkdir -p /cloudreve/cert
  echo "Put cloudreve.pem and cloudreve.key here to enable https" >/cloudreve/cert/README
fi

if [ ! -d /cloudreve/log ]; then
  mkdir -p /cloudreve/log
fi

/usr/bin/mysql_install_db --user=root --datadir=/cloudreve/mysql --skip-test-db
cp -f /etc/cloudreve.ini.tpl /etc/cloudreve.ini
if [ -f /cloudreve/cert/cloudreve.pem ] && [ -f /cloudreve/cert/cloudreve.key ]; then
  cat /etc/cloudreve-ssl.ini.tpl >>/etc/cloudreve.ini
fi

cp -f /usr/bin/cloudreve /cloudreve/cloudreve
/usr/bin/supervisord -c /etc/supervisor.conf
