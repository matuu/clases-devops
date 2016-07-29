#!/bin/bash
echo "***** #instalamos unzip"
apt-get -y update
apt-get -y install unzip

echo "*****  #Descargamos consul"
  cd /tmp
  wget -dcv http://192.168.3.251/consul/0.6.4/consul_0.6.4_linux_amd64.zip
  unzip consul_0.6.4_linux_amd64.zip
  cp consul /usr/local/sbin
  #creamos users dirs para consul
  useradd consul
  mkdir -p /etc/consul.d
  mkdir /var/consul
  chown consul:consul /var/consul

  # Mostramos resultado
  my_ip=$(ip r get 1 | sed -nr 's/.*src (\S+).*/\1/p')
  echo "*** INFO: READY, browse:"
  echo "    http://${my_ip?}/php-mysql"
  echo "*** INFO: END $0 $*"

  mv tmpconsul/client.json /etc/consul.d/
  mv tmpconsul/web.json /etc/consul.d/
  chmod 644 /etc/consul.d/*
  mv tmpconsul/consul /etc/init.d/
  chmod 755 /etc/init.d/consul

  cd /etc/init.d/
  update-rc.d consul defaults
  service consul start
