#!/bin/bash

mkdir -p cert
sudo chmod 777 ./cert

#docker run --name pxc-cert --rm \
#-v ./cert:/cert percona/percona-xtradb-cluster:8.0 \
#bash -c "mysql_ssl_rsa_setup && cp /var/lib/mysql/*pem /cert"