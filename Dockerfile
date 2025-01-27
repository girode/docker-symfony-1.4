# Symfony 1.5
#
# VERSION 1.0

FROM ubuntu:18.04
MAINTAINER grode, gabriel_rode@hotmail.com

# copy config file for mysql
#ADD files/my.cnf /etc/mysql/my.cnf

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

# Configuro la pass por defecto para la instalacion de mysql
RUN debconf-set-selections << "mysql-community-server mysql-community-server/root-pass password root"
RUN debconf-set-selections << "mysql-community-server mysql-community-server/re-root-pass password root"

# Hace que la instalacion de tz-data no se cuelgue
ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update && apt-get install -y \ 
   apache2 \
   libapache2-mod-php \
   git \          
   php \ 
   php-mbstring \ 
   php-zip \      
   php-fpm \
   php-pdo-mysql \
   php-mysqli \
   php-curl \
   php-cli \
   php-gd \
   mysql-server

# Install Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Para controlar que el servicio de mysql esta activo (o no)
# service mysql status

# Transfiero la aplicacion

COPY desafio_afip /var/app/desafio_afip

# Creacion de la base de datos 

ADD files/init_db.sh /tmp/init_db.sh
RUN chmod +x /tmp/init_db.sh
RUN /tmp/init_db.sh

# Configuro Apache 

# copy script create symfony
ADD files/symfony_config.sh /tmp/symfony_config.sh
RUN chmod +x /tmp/symfony_config.sh
RUN /tmp/symfony_config.sh

# apache2 configuration
ADD files/apache2_conf.sh /tmp/apache2_conf.sh
RUN chmod +x /tmp/apache2_conf.sh
RUN /tmp/apache2_conf.sh

# environment value
# ENV APACHE_RUN_USER www-data
# ENV APACHE_RUN_GROUP www-data
# ENV APACHE_LOG_DIR /var/log/apache2

# install ssh for maintainance
# RUN apt-get install -y openssh-server
# RUN mkdir -p /var/run/sshd

#RUN useradd -d /home/hoge -m -s /bin/bash hoge

# RUN echo root:password | chpasswd
# RUN echo 'rootpass ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# install editor tool
# RUN apt-get -y install less
# RUN apt-get -y install vim

# expose http & ssh port
# https://stackoverflow.com/questions/22111060/what-is-the-difference-between-expose-and-publish-in-docker
EXPOSE 8080
EXPOSE 22

# Arranco Apache
ADD files/startup.sh /tmp/startup.sh
RUN chmod +x /tmp/startup.sh
CMD /tmp/startup.sh