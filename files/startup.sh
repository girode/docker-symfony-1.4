#!/bin/bash

service mysql start
#service apache2 start
apachectl -D "FOREGROUND"

#"apachectl", "-D", "FOREGROUND"