#!/bin/bash

docker compose exec node1 mysql -uroot -proot \
-e "SELECT group_replication_switch_to_multi_primary_mode();"

