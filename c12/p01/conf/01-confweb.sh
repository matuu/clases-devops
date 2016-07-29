#!/bin/bash
echo "*** INFO: BEGIN $0 $*"
# Instalamos web app
cd /var/www/html
rm -rf php-mysql
git clone https://github.com/IBM-Bluemix/php-mysql.git
cd php-mysql

# Ajustamos la app para que se conecte a la DB
sed -i.bak 's/mysql_server_name = "127.0.0.1:3306"/mysql_server_name = "db-pgomez-01.node.cloud.um.edu.ar:3306"/g' db.php
sed -i.bak 's/mysql_username = "root"/mysql_username = "webapp"/g' db.php
sed -i.bak 's/mysql_password = ""/mysql_password = "supersecretisimo"/g' db.php
sed -i.bak 's/mysql_database = "test"/mysql_database = "webapp_db"/g' db.php
chown -R www-data:www-data /var/www/
service apache2 restart

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

