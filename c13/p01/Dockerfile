FROM ubuntu:14.04

ENV DEBIAN_FRONTEND=noninteractive
ENV APT_XTRA=--option=Dpkg::options::=--force-unsafe-io

RUN apt-get $APT_XTRA update
RUN apt-get $APT_XTRA install -y mysql-client apache2 phpmyadmin
RUN apt-get $APT_XTRA install -y supervisor

RUN mkdir -p /var/www/html

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY app-init.sh /usr/local/bin/app-init.sh

EXPOSE 80
RUN mkdir -p /var/lock/apache2
CMD ["/usr/bin/supervisord"]
