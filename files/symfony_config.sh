#!/bin/bash

cd /var/app/desafio_afip-master/

php composer install

# Configurar base de datos
php symfony configure:database "mysql:host=127.0.0.1;dbname=trader_desafio_afip" root root

# Directory Structure Rights
mkdir cache/
mkdir log/

#chmod 777 /var/app/desafio_afip-master/cache/ /var/app/desafio_afip-master/log/

php symfony project:permission

cd /