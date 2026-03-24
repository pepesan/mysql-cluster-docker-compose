# Ejemplo de despliegue de MySQL InnoDB Cluster con MySQL Shell y MySQL Router

## Despliegue
docker compose up -d
## Parada
docker compose down
## Acceso al MySQL Router
mysql -h 127.0.0.1 -P 6446 -u root -pmysql

## Acceso a MySQL Shell
docker compose run --rm --entrypoint mysqlsh mysql-shell --user=root -pmysql --host=mysql-server-1

## Dentro de la shell, conectamos al nodo
shell.connect('root:mysql@mysql-server-1:3306')
## Vemos la configuración del cluster
var cluster = dba.getCluster()
cluster.status()

## Nos salimos de la shell
\exit

