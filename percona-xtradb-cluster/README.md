# Ejemplo de Percona XtraDB Cluster

# Sigue los Pasos de los scripts de lanzamiento hasta el 17

## Fail over

18
19
20 
21
Cambia el compose.yaml del nodo 1

pxc-node1:
image: percona/percona-xtradb-cluster:8.4
hostname: pxc-node1
container_name: pxc-node1
environment:
- MYSQL_ROOT_PASSWORD=test1234#
- CLUSTER_NAME=pxc-cluster1
- CLUSTER_JOIN=pxc-node2,pxc-node3


