#!/bin/bash

cat scripts/multiPrimary.js | docker compose run --rm -T mysql-shell --js  --uri root:mysql@mysql-server-1:3306 \
 --verbose=2



