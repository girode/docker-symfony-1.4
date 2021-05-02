# Nota: En Apache 2.2 se usa Allow from All en vez de Require all granted (2.4)
# Para saber la version de apache: apache2 -v

cat << EOF > /etc/apache2/sites-available/desafio_afip.conf

Listen *:8080

<VirtualHost *:8080>
  DocumentRoot "/var/app/desafio_afip/web"
  DirectoryIndex index.php
  <Directory "/var/app/desafio_afip/web">
    AllowOverride All
    Require all granted
  </Directory>

  Alias /sf /var/app/desafio_afip/lib/vendor//friendsofsymfony1/symfony1/data/web/sf
  <Directory "/var/app/desafio_afip/lib/vendor//friendsofsymfony1/symfony1/data/web/sf">
    AllowOverride All
    Require all granted
  </Directory>

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined

</VirtualHost>
EOF

a2ensite desafio_afip.conf
a2dissite 000-default.conf

a2enmod rewrite

# Si nunca lo prendi, necesito restartear?
#systemctl restart apache2 # no funca en startuo

#service apache2 reload
#service apache2 status


