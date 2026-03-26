#!/bin/bash

mysql -h 127.0.0.1 -P 3306 -u root -proot -e "
CREATE USER 'exporter'@'%' IDENTIFIED BY 'exporterpass' WITH MAX_USER_CONNECTIONS 3;
GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'exporter'@'%';
FLUSH PRIVILEGES;
"

mysql -h 127.0.0.1 -P 3306 -u root -proot -e "SELECT user, host FROM mysql.user WHERE user='exporter';"





