#!/bin/bash

( cd /var/www/html/php-mysql
  echo '<?php header("location: php-mysql/");?>' > /var/www/html/index.php
  test -f db.php.bak && exit 0 # edit only once
  sed -i.bak \
      -e 's/mysql_server_name = "127.0.0.1:3306"/mysql_server_name = getenv("APP_DB_HOST")/g' \
      -e 's/mysql_username = "root"/mysql_username = getenv("APP_DB_USER")/g'\
      -e 's/mysql_password = ""/mysql_password = getenv("APP_DB_PASSWORD")/g'\
      -e 's/mysql_database = "test"/mysql_database = getenv("APP_DB_NAME")/g'\
       /var/www/html/php-mysql/db.php
)
