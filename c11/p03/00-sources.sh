#!/bin/bash
(set -x; test -d php-mysql || git clone https://github.com/IBM-Bluemix/php-mysql.git)
echo "*** Ahora edita, por ej, agrega algo donde dice 'This introductory ...':"
echo "php-mysql/index.php"
