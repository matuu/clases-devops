FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive
ENV APT_XTRA=--option=Dpkg::options::=--force-unsafe-io

RUN apt-get $APT_XTRA update
RUN apt-get $APT_XTRA install -y mysql-server apache2 libapache2-mod-php php-mysql php-common git-core

RUN mkdir -p /var/www/html; cd /var/www/html; git clone https://github.com/IBM-Bluemix/php-mysql.git

RUN apt-get $APT_XTRA install -y supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY db-init.sh /usr/local/bin/db-init.sh
EXPOSE 80
RUN mkdir -p /var/lock/apache2
CMD ["/usr/bin/supervisord"]
