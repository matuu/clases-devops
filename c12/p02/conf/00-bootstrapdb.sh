#!/bin/bash
echo "*** INFO: BEGIN $0 $*"

echo "*** configura proxy:"
echo  "Acquire::http::Proxy \"http://172.16.16.1:8000/\";i\nAcquire::https::Proxy \"http://172.16.16.1:8000/\";\nAcquire::ftp::Proxy \"ftp://172.16.16.1:8000/\";" > /etc/apt/apt.conf.d/05proxy

echo "*** configuramos usuarios"

echo "*** instalamos paquetes:"
export DEBIAN_FRONTEND=noninteractive
export APT_XTRA=--option=Dpkg::options::=--force-unsafe-io

apt-get $APT_XTRA -y update
apt-get $APT_XTRA install -y mysql-server unzip

echo "*** INFO: END $0 $*"

