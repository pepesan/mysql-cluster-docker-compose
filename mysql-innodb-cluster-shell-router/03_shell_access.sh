#!/bin/bash

docker compose run --rm -it --entrypoint mysqlsh mysql-shell \
  --user=root --password=mysql --host=mysql-server-1 --port=3306 --js

# se sale con \exit

