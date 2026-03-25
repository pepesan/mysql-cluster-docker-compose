#!/bin/bash

docker exec -it pxc-node1  mysql -u root -p'test1234#' --verbose -e \
"CREATE USER IF NOT EXISTS 'haproxy_user'@'%' IDENTIFIED BY ''; \
GRANT USAGE ON *.* TO 'haproxy_user'@'%'; \
FLUSH PRIVILEGES;"

 docker compose exec pxc-node1 mysql --verbose -u root -p'test1234#' -e "SELECT user, host FROM mysql.user WHERE user='haproxy_check';"