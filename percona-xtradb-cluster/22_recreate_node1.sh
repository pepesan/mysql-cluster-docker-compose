#!/bin/bash

# Antes modifica el compose.yaml
#  pxc-node1:
#    image: percona/percona-xtradb-cluster:8.4
#    hostname: pxc-node1
#    container_name: pxc-node1
#    environment:
#      - MYSQL_ROOT_PASSWORD=test1234#
#      - CLUSTER_NAME=pxc-cluster1
#      # LA CLAVE ES ESTA LINEA
#      - CLUSTER_JOIN=pxc-node2,pxc-node3
#    ports:
#      - "3307:3306"
#    volumes:
#      - ./cert:/cert
#      - ./config:/etc/percona-xtradb-cluster.conf.d
##    depends_on:
##      pxc-certs-gen:
##        condition: service_completed_successfully
#    healthcheck:
#      test: "mysqladmin ping -u root -p$${MYSQL_ROOT_PASSWORD}"
#      interval: 2s
#      retries: 20
docker compose rm -sf pxc-node1 && docker compose up -d pxc-node1