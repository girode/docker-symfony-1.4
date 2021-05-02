#!/bin/bash

service mysql start

# config for root login from remote
#RUN (/usr/bin/mysqld_safe &); sleep 5; echo "grant all privileges on *.* to root@'%';" | mysql -u root # -ppassword
#CMD ["/usr/bin/mysqld_safe"]

/usr/bin/mysqld_safe --skip-grant-tables &
sleep 5
# https://stackoverflow.com/a/46908573
mysql -u root < /var/app/desafio_afip/data/sql/trader_desafio_afip.sql
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root'"

# hack for not start mysql-server cause of /sbin/initctl
#RUN dpkg-divert --local --rename --add /sbin/initctl
#RUN ln -s /bin/true /sbin/initctl

# install mysql
#RUN apt-get install -y -o Dpkg::Options::="--force-confold" mysql-common
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y mysql-server
#RUN apt-get install -y libapache2-mod-auth-mysql php5-mysql


