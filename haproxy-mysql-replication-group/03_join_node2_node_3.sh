#!/bin/bash

for N in 2 3
do docker compose exec node$N mysql -uroot -proot \
-e "change master to master_user='repl' for channel 'group_replication_recovery';" \
-e "START GROUP_REPLICATION;"
done

