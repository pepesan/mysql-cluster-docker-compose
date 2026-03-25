#!/bin/bash

docker compose exec node1 mysql -uroot -proot \
-e "CREATE USER 'access'@'%' IDENTIFIED BY 'access';" \
-e "GRANT ALL PRIVILEGES ON *.* TO 'access'@'%' WITH GRANT OPTION;" \
-e "ALTER USER 'access'@'%' IDENTIFIED WITH mysql_native_password BY 'access';" \
-e "FLUSH PRIVILEGES;"


