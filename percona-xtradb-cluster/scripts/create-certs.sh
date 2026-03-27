#!/bin/bash
set -euxo pipefail

mkdir -p /cert

openssl genrsa -out /cert/ca-key.pem 2048
openssl req -new -x509 -nodes -days 3650 \
  -key /cert/ca-key.pem \
  -subj "/CN=PXC-CA" \
  -out /cert/ca.pem

openssl genrsa -out /cert/server-key.pem 2048
openssl req -new \
  -key /cert/server-key.pem \
  -subj "/CN=PXC-SERVER" \
  -out /cert/server-req.pem
openssl x509 -req \
  -in /cert/server-req.pem \
  -days 3650 \
  -CA /cert/ca.pem \
  -CAkey /cert/ca-key.pem \
  -set_serial 01 \
  -out /cert/server-cert.pem

openssl genrsa -out /cert/client-key.pem 2048
openssl req -new \
  -key /cert/client-key.pem \
  -subj "/CN=PXC-CLIENT" \
  -out /cert/client-req.pem
openssl x509 -req \
  -in /cert/client-req.pem \
  -days 3650 \
  -CA /cert/ca.pem \
  -CAkey /cert/ca-key.pem \
  -set_serial 02 \
  -out /cert/client-cert.pem

chown -R 1001:1001 /cert
chmod 600 /cert/*-key.pem
chmod 644 /cert/*.pem

ls -la /cert