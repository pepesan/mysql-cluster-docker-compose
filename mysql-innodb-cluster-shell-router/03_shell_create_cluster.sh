#!/bin/bash

cat scripts/setupCluster.js | docker compose run --rm -T mysql-shell --js
# Recuerda arrancar los contenedores mientras ejecutas este script
# docker compose start mysql-server-2
# docker compose start mysql-server-3


