#!/bin/bash

# Comprobamos que la replicación funciona, ejecutamos varias veces el comando anterior y veremos que el hostname va cambiando entre los nodos del cluster
for N in 1 2 3; do
echo "--- Datos en node$N ---";
docker compose exec node$N mysql -uaccess -paccess test -e "SELECT @@hostname, id, nombre FROM usuarios;";
done