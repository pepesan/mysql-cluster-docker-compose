# mariadb-galera-cluster
mariadb 10.1 galera-cluster  docker-compose
Galera is a full synchronous HA Cluster.
Data can be changed on all nodes, Active-Active multi-master configuration - read / write on all nodes

* This docker image does not work for automatic migration of sql files such as the official mariadb image when the container image is deployed.

                
                
## How to use

1.Galera Cluster container starting 
```shell
docker-compose  up -d
```

2.Galera Cluster Creates a database user in mysql schema and app schema within the node1 container.

Puedo conectar al nodo 1
```shell
mysql -h 127.0.0.1 -P 13306 -u root -piamgroot
```

7.Confirm the sync state of Galera working and data migration at each node.
```shell
show status like 'wsrep_%';

show status like  'wsrep_incoming_addresses';

SHOW STATUS LIKE 'wsrep_cluster_size';
```
## insertamos algo en node1
```shell
docker exec -it node1-mariadb mysql -u root -piamgroot -D MODEL -e "INSERT INTO API (id, name, symbol, rank) VALUES ('cardano', 'Cardano', 'ADA', 10);"
```

# confirmamos que se ha insertado en node1
```shell
docker exec -it node1-mariadb mysql -u root -piamgroot -D MODEL -e "SELECT * FROM API;"
```

# confirmamos que se ha insertado en node2
```shell
docker exec -it node2-mariadb mysql -u root -piamgroot -D MODEL -e "SELECT * FROM API;"
```
# confirmamos que se ha insertado en node3
```shell
docker exec -it node3-mariadb mysql -u root -piamgroot -D MODEL -e "SELECT * FROM API;"
```
## Accedemos al HAProxy
http://localhost:2999/stats

Si pide usuario y contraseña, el usuario es admin y la contraseña es admin

## Acceso desde el HAProxy
```shell
mysql -h 127.0.0.1 -P 3306 -u testuser -piamgroot -e "SELECT @@hostname;"
```

# Prueba del balanceo de carga
```shell
for i in {1..6}; do mysql -h 127.0.0.1 -P 3306 -u testuser -piamgroot -N -s -e "SELECT @@hostname;"; done
```

## prueba de failover (pendiente)
Modificamos el compose.yaml para cambiar la config del nodo 2
```yaml
      command:
        - "mariadbd"
        - "--wsrep-on=ON"
        - "--wsrep-provider=/usr/lib/galera/libgalera_smm.so"
        - "--wsrep-cluster-address=gcomm://node1-mariadb,node2-mariadb,node3-mariadb"
        - "--wsrep-cluster-name=maria_cluster"
        - "--wsrep-node-name=node2-mariadb"
        - "--binlog-format=ROW"
        - "--innodb-autoinc-lock-mode=2"
```

docker compose up -d node2-mariadb

Desde el nodo 2, confirmamos el estado del cluster

docker exec -it node2-mariadb mariadb -u root -piamgroot -e "SHOW STATUS LIKE 'wsrep_cluster_size';"

Modificamos el compose.yaml para cambiar la config del nodo 3
```yaml
      command:
        - "mariadbd"
        - "--wsrep-on=ON"
        - "--wsrep-provider=/usr/lib/galera/libgalera_smm.so"
        - "--wsrep-cluster-address=gcomm://node1-mariadb,node2-mariadb,node3-mariadb"
        - "--wsrep-cluster-name=maria_cluster"
        - "--wsrep-node-name=node2-mariadb"
        - "--binlog-format=ROW"
        - "--innodb-autoinc-lock-mode=2"
```

docker compose up -d node3-mariadb

Desde el nodo 3, confirmamos el estado del cluster

docker exec -it node3-mariadb mariadb -u root -piamgroot -e "SHOW STATUS LIKE 'wsrep_cluster_size';"


Modificamos el compose.yaml para cambiar la config del nodo 1
```yaml
    command:
      - "mariadbd"
      - "--wsrep-on=ON"
      - "--wsrep-provider=/usr/lib/galera/libgalera_smm.so"
      - "--wsrep-cluster-address=gcomm://node1-mariadb,node2-mariadb,node3-mariadb"
      - "--wsrep-cluster-name=maria_cluster"
      - "--wsrep-node-name=node1-mariadb"
      - "--binlog-format=ROW"
      - "--innodb-autoinc-lock-mode=2"
```

Evitamos que falle en el arranque
```shell
docker run --rm -v $(pwd)/volumes/galeranode1/mariadb:/var/lib/mysql busybox sed -i 's/safe_to_bootstrap: 0/safe_to_bootstrap: 1/' /var/lib/mysql/grastate.dat
```

Volvemos a arrancar el nodo 1
```shell
docker compose up -d node1-mariadb
```

Desde el nodo 1, confirmamos el estado del cluster

docker exec -it node1-mariadb mariadb -u root -piamgroot -e "SHOW STATUS LIKE 'wsrep_cluster_size';"


Probamos acceder desde el nodo 2 para mirar el estado del cluster
```shell
docker exec -it node2-mariadb mariadb -u root -piamgroot -e "SHOW STATUS LIKE 'wsrep_cluster_size';"
```

+--------------------+-------+
| Variable_name      | Value |
+--------------------+-------+
| wsrep_cluster_size |3     |
+--------------------+-------+

## metemos un dato nuevo desde HAProxy
```shell
mysql -h 127.0.0.1 -P 3306 -u testuser -piamgroot -D MODEL -e "INSERT INTO API (id, name, symbol, rank) VALUES ('polkadot', 'Polkadot', 'DOT', 12);"
```

## comprobamos que se ha insertado en node1
```shell
docker exec -it node1-mariadb mariadb -u root -piamgroot -D MODEL -e "SELECT * FROM API;"
```
## comprobamos que se ha insertado en node2
```shell
docker exec -it node2-mariadb mariadb -u root -piamgroot -D MODEL -e "SELECT * FROM API;"
```
## comprobamos que se ha insertado en node3
```shell
docker exec -it node3-mariadb mariadb -u root -piamgroot -D MODEL -e "SELECT * FROM API;"
```
## consultamos desde el HAProxy para confirmar que se ha insertado
```shell
for i in {1..6}; do mysql -h 127.0.0.1 -P 3306 -u testuser -piamgroot -N -s -e "SELECT @@hostname;"; done
```



