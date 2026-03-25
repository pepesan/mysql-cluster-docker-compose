#!/bin/bash

docker compose run --rm --entrypoint mysqlsh mysql-shell \
  --user=root --password=mysql --host=mysql-server-1 --port=3306 \
  --js \
  -e "var cluster = dba.getCluster(); print(JSON.stringify(cluster.status(), null, 2));"

