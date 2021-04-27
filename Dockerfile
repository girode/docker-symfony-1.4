# Symfony 1.5
#
# VERSION 1.0

FROM ubuntu:18.04
MAINTAINER grode, gabriel_rode@hotmail.com

# copy config file for mysql
#ADD files/my.cnf /etc/mysql/my.cnf

#
#
#


# Configuro el repositorio de paquetes
# Referencias para saber que significa cada cosa:
#   - https://askubuntu.com/questions/1032415/what-is-deb-deb-src-stable-xenial-main-in-etc-apt-sources-list
#   - https://askubuntu.com/questions/58364/whats-the-difference-between-multiverse-universe-restricted-and-main/58365#58365
# Linea orignal
# RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list

# Linea tuneada
# RUN echo "deb http://us.archive.ubuntu.com/ubuntu bionic main universe" > /etc/apt/sources.list
# RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ bionic main restricted" > /etc/apt/sources.list
# RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ bionic-updates main restricted" > /etc/apt/sources.list
# RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ bionic universe" > /etc/apt/sources.list



RUN apt-get update && apt-get install apache2 -y

# RUN apt-get update && apt-get install -y \ 
# 	apache2 \
# 	php \
# 	libapache2-mod-php

# install apache2
#RUN apt-get -y install apache2

# install php
#RUN apt-get -y install php5
#RUN apt-get -y install libapache2-mod-php5

# hack for not start mysql-server cause of /sbin/initctl
#RUN dpkg-divert --local --rename --add /sbin/initctl
#RUN ln -s /bin/true /sbin/initctl

# install mysql
#RUN apt-get install -y -o Dpkg::Options::="--force-confold" mysql-common
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y mysql-server
#RUN apt-get install -y libapache2-mod-auth-mysql php5-mysql

# config for root login from remote
#RUN (/usr/bin/mysqld_safe &); sleep 5; echo "grant all privileges on *.* to root@'%';" | mysql -u root # -ppassword
#CMD ["/usr/bin/mysqld_safe"]

## Aca empiezo a tocar para customiza mi instalación

# install subversion
#RUN apt-get -y install subversion

# create directory for libs
# RUN mkdir -p /home/sfproject/lib/vendor

# install symfony via svn
# RUN cd /home/sfproject/lib/vendor
# RUN svn checkout http://svn.symfony-project.com/branches/1.4/ /home/sfproject/lib/vendor/symfony

# copy script create symfony
# ADD files/symfony_create_project.sh /home/sfproject/symfony_create_project.sh
# RUN chmod +x /home/sfproject/symfony_create_project.sh

# create project
# RUN /home/sfproject/symfony_create_project.sh

# apache2 configuration
# ADD files/apache2_conf.sh /home/sfproject/apache2_conf.sh
# RUN chmod +x /home/sfproject/apache2_conf.sh
# RUN /home/sfproject/apache2_conf.sh

# environment value
# ENV APACHE_RUN_USER www-data
# ENV APACHE_RUN_GROUP www-data
# ENV APACHE_LOG_DIR /var/log/apache2

# add config for swift_mailer
# ADD files/factories_yml.sh /home/sfproject/factories_yml.sh
# RUN chmod +x /home/sfproject/factories_yml.sh
# RUN /home/sfproject/factories_yml.sh

# add code for send mail example
# ADD files/index.php /home/sfproject/web/index.php

# install ssh for maintainance
# RUN apt-get install -y openssh-server
# RUN mkdir -p /var/run/sshd

#RUN useradd -d /home/hoge -m -s /bin/bash hoge

# RUN echo root:password | chpasswd
# RUN echo 'rootpass ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# install editor tool
# RUN apt-get -y install less
# RUN apt-get -y install vim

# ADD files/myEmail.class.php /home/sfproject/apps/frontend/lib/myEmail.class.php
# ADD files/app.yml /home/sfproject/apps/frontend/config/app.yml
# ADD files/_registrationHTML.php /home/sfproject/apps/frontend/modules/mail/_registrationHTML.php
# ADD files/_registrationTEXT.php /home/sfproject/apps/frontend/modules/mail/_registrationTEXT.php

# expose http & ssh port
#EXPOSE 8080
EXPOSE 80
EXPOSE 22

# 
#CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]

