#!/bin/bash

mysql -h 127.0.0.1 -P 6446 -u root -pmysql -e "SHOW TABLES FROM tienda_online LIKE 'usuarios';"

mysql -h 127.0.0.1 -P 6446 -u root -pmysql -e "SELECT * FROM tienda_online.usuarios;"