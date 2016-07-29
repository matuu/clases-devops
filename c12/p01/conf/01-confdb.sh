#!/bin/bash
echo "*** INFO: BEGIN $0 $*"
#Ponemos el mysql a atender por la red
sed -i.bak 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf
#Restarteamos
/etc/init.d/mysql restart
echo "GRANT ALL PRIVILEGES ON *.* TO 'webapp'@'%' IDENTIFIED BY 'supersecretisimo';" | mysql -u root
### Con storage, ahora no la DROPeamos ;)
# echo "DROP DATABASE webapp_db; " | mysql -u root
echo "CREATE DATABASE webapp_db" | mysql -u root
echo "*** INFO: END $0 $*"
echo "/usr/local/src/boot_ip.sh" >> /etc/rc.local

service mysql restart

#Descargamos consul
cd /tmp
#wget http://192.168.3.251/consul/0.6.4/consul_0.6.4_linux_amd64.zip
mv /tmp/tmpconsul/*.zip /tmp/
unzip *.zip
cp consul /usr/local/sbin
#creamos users dirs para consul
useradd -d /var/consul -m consul
mkdir -p /etc/consul.d

cp /tmp/tmpconsul/consul  /etc/init.d/
chmod 0755 /etc/init.d/consul
cp /tmp/tmpconsul/*.json /etc/consul.d/
chmod 0644 /etc/consul.d/*
update-rc.d consul defaults
service consul start &

# Mostramos resultado
my_ip=$(ip r get 1 | sed -nr 's/.*src (\S+).*/\1/p')
echo "*** INFO: READY, browse:"
echo "    http://${my_ip?}/php-mysql"
echo "*** INFO: END $0 $*"


