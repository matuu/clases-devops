#!/bin/bash


#Ponemos el mysql a atender por la red
sed -i.bak 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf
#Restarteamos
/etc/init.d/mysql restart

echo "GRANT ALL PRIVILEGES ON *.* TO 'webapp'@'%' IDENTIFIED BY 'supersecretisimo';" | mysql -u root
echo "DROP DATABASE webapp_db; " | mysql -u root
echo "CREATE DATABASE webapp_db" | mysql -u root
