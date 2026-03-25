#!/bin/bash

docker compose exec node1 mysql -uroot -proot \
-e "SHOW VARIABLES LIKE 'group_replication_single_primary_mode';"

