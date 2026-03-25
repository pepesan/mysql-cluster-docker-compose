#!/bin/bash

docker compose run --rm --entrypoint mysqlsh mysql-shell \
  --user=root --password=mysql --host=mysql-server-1 --port=3306 \
  -e "print(dba.getCluster().status())"

