# Configurar base de datos
php /var/app/desafio_afip-master/symfony configure:database "mysql:host=127.0.0.1;dbname=trader_desafio_afip" root root

# Directory Structure Rights
mkdir /var/app/desafio_afip-master/cache/
mkdir /var/app/desafio_afip-master/log/

chmod 777 /var/app/desafio_afip-master/cache/ /var/app/desafio_afip-master/log/

