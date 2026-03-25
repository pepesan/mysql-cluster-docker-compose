#!/bin/bash

docker exec -it node1-mariadb mariadb -u root -piamgroot -D MODEL \
-e "INSERT INTO API (id, name, symbol, rank) VALUES ('cardano', 'Cardano', 'ADA', 10);"