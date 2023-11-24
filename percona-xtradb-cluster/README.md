# Ejemplo de Percona XtraDB Cluster

## Documentación oficial

* Creado fichero config/custom.cnf de los nodos
### Generar certificados
```shell
docker run --name pxc-cert --rm \
-v ./cert:/cert percona/percona-xtradb-cluster:8.0 \
mysql_ssl_rsa_setup -d /cert
```
