#!/bin/bash

docker exec -it node1-mariadb mysql -u root -piamgroot -e \
"CREATE USER IF NOT EXISTS 'haproxy_user'@'%' IDENTIFIED BY ''; \
 GRANT USAGE ON *.* TO 'haproxy_user'@'%'; \
 FLUSH PRIVILEGES;"