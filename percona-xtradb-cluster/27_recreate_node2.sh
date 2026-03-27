#!/bin/bash

# Antes modifica el compose.yaml
#  pxc-node2:
#    image: percona/percona-xtradb-cluster:8.4
#    hostname: pxc-node2
#    container_name: pxc-node2
#    environment:
#      - MYSQL_ROOT_PASSWORD=test1234#
#      - CLUSTER_NAME=pxc-cluster1
#      # LA CLAVE ES ESTA LINEA
#      - CLUSTER_JOIN=pxc-node1,pxc-node3
#    ports:
#      - "3308:3306"
#    volumes:
#      - ./cert:/cert
#      - ./config:/etc/percona-xtradb-cluster.conf.d
#    healthcheck:
#      test: "mysqladmin ping -u root -p$${MYSQL_ROOT_PASSWORD}"
#      interval: 2s
#      retries: 20
docker compose rm -sf pxc-node2 && docker compose up -d pxc-node2