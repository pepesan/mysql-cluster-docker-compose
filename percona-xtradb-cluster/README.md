# Ejemplo de Percona XtraDB Cluster

## Documentación oficial

* Creado fichero config/custom.cnf de los nodos
### Generar certificados
```shell
docker run --name pxc-cert --rm \                          
-v ./cert:/cert percona/percona-xtradb-cluster:8.0 \
bash -c "mysql_ssl_rsa_setup && cp /var/lib/mysql/*pem /cert"
```

### Montar el primer nodo
docker run -d \
-e MYSQL_ROOT_PASSWORD=test1234# \
-e CLUSTER_NAME=pxc-cluster1 \
--name=pxc-node1 \
--net=pxc-network \
-v ./cert:/cert \
-v ./config:/etc/percona-xtradb-cluster.conf.d \
percona/percona-xtradb-cluster:8.0

#### Montamos el segundo nodo
docker run -d \
-e MYSQL_ROOT_PASSWORD=test1234# \
-e CLUSTER_NAME=pxc-cluster1 \
-e CLUSTER_JOIN=pxc-node1 \
--name=pxc-node2 \
--net=pxc-network \
-v ./cert:/cert \
-v ./config:/etc/percona-xtradb-cluster.conf.d \
percona/percona-xtradb-cluster:8.0
#### Montamos el segundo nodo
docker run -d \
-e MYSQL_ROOT_PASSWORD=test1234# \
-e CLUSTER_NAME=pxc-cluster1 \
-e CLUSTER_JOIN=pxc-node1 \
--name=pxc-node2 \
--net=pxc-network \
-v ./cert:/cert \
-v ./config:/etc/percona-xtradb-cluster.conf.d \
percona/percona-xtradb-cluster:8.0
#### Montamos el tercer nodo
docker run -d \
-e MYSQL_ROOT_PASSWORD=test1234# \
-e CLUSTER_NAME=pxc-cluster1 \
-e CLUSTER_JOIN=pxc-node1 \
--name=pxc-node3 \
--net=pxc-network \
-v ./cert:/cert \
-v ./config:/etc/percona-xtradb-cluster.conf.d \
percona/percona-xtradb-cluster:8.0

### Nos conectamos al primer nodo
docker exec -it pxc-node1 /usr/bin/mysql -uroot -ptest1234#

### Comprobamos el estado de cluster
show status like 'wsrep%';

### Salida esperada
+------------------------------+-------------------------------------------------+
| Variable_name                | Value                                           |
+------------------------------+-------------------------------------------------+
| wsrep_local_state_uuid       | 625318e2-9e1c-11e7-9d07-aee70d98d8ac            |
...
| wsrep_local_state_comment    | Synced                                          |
...
| wsrep_incoming_addresses     | 172.18.0.2:3306,172.18.0.3:3306,172.18.0.4:3306 |
...
| wsrep_cluster_conf_id        | 3                                               |
| wsrep_cluster_size           | 3                                               |
| wsrep_cluster_state_uuid     | 625318e2-9e1c-11e7-9d07-aee70d98d8ac            |
| wsrep_cluster_status         | Primary                                         |
| wsrep_connected              | ON                                              |
...
| wsrep_ready                  | ON                                              |
+------------------------------+-------------------------------------------------+
59 rows in set (0.02 sec)


