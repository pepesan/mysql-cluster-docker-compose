#!/bin/bash

docker compose exec node1 mysql -uroot -proot \
-e "CREATE USER 'haproxy_user'@'%' IDENTIFIED BY '';" \
-e "ALTER USER 'haproxy_user'@'%' IDENTIFIED WITH mysql_native_password BY '';" \
-e "GRANT USAGE ON *.* TO 'haproxy_user'@'%';" \
-e "FLUSH PRIVILEGES;"

