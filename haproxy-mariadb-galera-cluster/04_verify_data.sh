#!/bin/bash

# confirmamos que se ha insertado en node1

docker exec -it node1-mariadb mysql -u root -piamgroot -D MODEL -e \
"SELECT @@hostname AS 'NODE_ID', id, name, symbol, rank FROM API;"


# confirmamos que se ha insertado en node2

docker exec -it node2-mariadb mysql -u root -piamgroot -D MODEL -e \
"SELECT @@hostname AS 'NODE_ID', id, name, symbol, rank FROM API;"

# confirmamos que se ha insertado en node3

docker exec -it node3-mariadb mysql -u root -piamgroot -D MODEL -e \
"SELECT @@hostname AS 'NODE_ID', id, name, symbol, rank FROM API;"