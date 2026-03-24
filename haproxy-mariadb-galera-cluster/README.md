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
Paramos el nodo
```shell
docker compose stop node1-mariadb
```

Probamos acceder desde el nodo 2 para mirar el estado del cluster
```shell
docker exec -it node2-mariadb mysql -u root -piamgroot -e "SHOW STATUS LIKE 'wsrep_cluster_size';"
```

+--------------------+-------+
| Variable_name      | Value |
+--------------------+-------+
| wsrep_cluster_size | 2     |
+--------------------+-------+

## metemos un dato nuevo desde HAProxy
```shell
mysql -h 127.0.0.1 -P 3306 -u testuser -piamgroot -D MODEL -e "INSERT INTO API (id, name, symbol, rank) VALUES ('polkadot', 'Polkadot', 'DOT', 12);"
```

## Recuperamos el nodo
```shell
docker compose start node1-mariadb
```

Probamos acceder desde el nodo 2 para mirar el estado del cluster
```shell
docker exec -it node2-mariadb mysql -u root -piamgroot -e "SHOW STATUS LIKE 'wsrep_cluster_size';"
```
+--------------------+-------+
| Variable_name      | Value |
+--------------------+-------+
| wsrep_cluster_size | 2     |
+--------------------+-------+






