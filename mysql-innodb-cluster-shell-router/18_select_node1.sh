#!/bin/bash


mysql -h 127.0.0.1 -P 3301 -u root -pmysql -e "SELECT * FROM tienda_online.usuarios;"
