#!/bin/bash

cd /var/www/html
rm -rf php-mysql
git clone https://github.com/IBM-Bluemix/php-mysql.git
cd php-mysql

#Ajustamos la app para que se conecte a la DB
sed -i.bak 's/mysql_server_name = "127.0.0.1:3306"/mysql_server_name = "192.168.122.10:3306"/g' db.php
sed -i.bak 's/mysql_username = "root"/mysql_username = "webapp"/g' db.php
sed -i.bak 's/mysql_password = ""/mysql_password = "supersecretisimo"/g' db.php
sed -i.bak 's/mysql_database = "test"/mysql_database = "webapp_db"/g' db.php
