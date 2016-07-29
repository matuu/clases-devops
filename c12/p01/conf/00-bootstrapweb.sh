#!/bin/bash
echo "*** INFO: BEGIN $0 $*"

echo "*** configura proxy:"
echo  "Acquire::http::Proxy \"http://172.16.16.1:8000/\";i\nAcquire::https::Proxy \"http://172.16.16.1:8000/\";\nAcquire::ftp::Proxy \"ftp://172.16.16.1:8000/\";" >/etc/apt/apt.conf.d/05proxy

echo "*** configuramos usuarios"

echo "*** instalamos paquetes:"
export DEBIAN_FRONTEND=noninteractive
export APT_XTRA=--option=Dpkg::options::=--force-unsafe-io

apt-get $APT_XTRA -y update
apt-get $APT_XTRA install -y apache2 unzip phpmyadmin

#apt-get install -qy unzip apache2 
#apt-get install -qqy phpmyadmin

cat <<EOF > /var/www/html/index2.html
<html>
<body>
<p>hostname is: $(hostname)</p>
</body>
</html>
EOF
chown -R www-data:www-data /var/www/
