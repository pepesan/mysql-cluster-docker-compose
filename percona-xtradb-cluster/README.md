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
22
23
24
25
26
Cambia el compose.yaml en el nodo 2
  pxc-node2:
    image: percona/percona-xtradb-cluster:8.4
    container_name: pxc-node2
    hostname: pxc-node2
    environment:
      - MYSQL_ROOT_PASSWORD=test1234#
      - CLUSTER_NAME=pxc-cluster1
      #- CLUSTER_JOIN=pxc-node1
      - CLUSTER_JOIN=pxc-node1,pxc-node3

27
28
  pxc-node3:
    image: percona/percona-xtradb-cluster:8.4
    container_name: pxc-node3
    hostname: pxc-node3
    environment:
      - MYSQL_ROOT_PASSWORD=test1234#
      - CLUSTER_NAME=pxc-cluster1
      #- CLUSTER_JOIN=pxc-node1
      - CLUSTER_JOIN=pxc-node1,pxc-node2,pxc-node3
29



