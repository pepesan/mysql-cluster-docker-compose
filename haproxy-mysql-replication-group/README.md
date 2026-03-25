# Mysql Replication Group
docker compose up -d

## Comprobamos que los contenedores están levantados
docker compose ps

## Configure node1
docker compose exec node1 mysql -uroot -proot \
-e "SET @@GLOBAL.group_replication_bootstrap_group=1;" \
-e "create user 'repl'@'%';" \
-e "GRANT REPLICATION SLAVE ON *.* TO repl@'%';" \
-e "flush privileges;" \
-e "change master to master_user='root' for channel 'group_replication_recovery';" \
-e "START GROUP_REPLICATION;" \
-e "SET @@GLOBAL.group_replication_bootstrap_group=0;" \
-e "SELECT * FROM performance_schema.replication_group_members;"
## Configure rest of nodes
for N in 2 3
do docker compose exec node$N mysql -uroot -proot \
-e "change master to master_user='repl' for channel 'group_replication_recovery';" \
-e "START GROUP_REPLICATION;"
done
## Final group replication checks
for N in 1 2 3
do docker compose exec node$N mysql -uroot -proot \
-e "SHOW VARIABLES WHERE Variable_name = 'hostname';" \
-e "SELECT * FROM performance_schema.replication_group_members;"
done
# Comprobamos el modo de replicación
docker compose exec node1 mysql -uroot -proot \
-e "SHOW VARIABLES LIKE 'group_replication_single_primary_mode';"

## Colocarlo en modo multi primary (master)
docker compose exec node1 mysql -uroot -proot \
-e "SELECT group_replication_switch_to_multi_primary_mode();"

# Comprobamos el modo de replicación (debería estar en OFF)
docker compose exec node1 mysql -uroot -proot \
-e "SHOW VARIABLES LIKE 'group_replication_single_primary_mode';"
# Comprobamos el nodo 1  ( Debería estar en 0 y 0)
docker compose exec node1 mysql -uroot -proot \
-e "SELECT @@global.read_only, @@global.super_read_only;"
# Comprobamos el nodo 2  ( Debería estar en 0 y 0)
docker compose exec node2 mysql -uroot -proot \
-e "SELECT @@global.read_only, @@global.super_read_only;"
# Comprobamos el nodo 3  ( Debería estar en 0 y 0)
docker compose exec node3 mysql -uroot -proot \
-e "SELECT @@global.read_only, @@global.super_read_only;"

## Create haproxy user
docker compose exec node1 mysql -uroot -proot \
-e "CREATE USER 'haproxy_user'@'%' IDENTIFIED BY '';" \
-e "ALTER USER 'haproxy_user'@'%' IDENTIFIED WITH mysql_native_password BY '';" \
-e "GRANT ALL PRIVILEGES ON *.* TO 'haproxy_user'@'%' WITH GRANT OPTION;" \
-e "FLUSH PRIVILEGES;"



#### via consola mysql (opcional)
CREATE USER 'haproxy_user'@'%' IDENTIFIED BY '';
ALTER USER 'haproxy_user'@'%' IDENTIFIED WITH mysql_native_password BY '';
GRANT ALL PRIVILEGES ON *.* TO 'haproxy_user'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
## Comprobamos los privilegios en cada nodo
for N in 1 2 3
do docker compose exec node$N mysql -uroot -proot \
-e "SHOW VARIABLES WHERE Variable_name = 'hostname';" \
-e "SHOW GRANTS FOR 'haproxy_user'@'%';" 
done


# Acceso a HAProxy
http://localhost:2999/stats

Nos pedirá un usuario y contraseña, admin/admin



### Create access user
docker compose exec node1 mysql -uroot -proot \
-e "CREATE USER 'access'@'%' IDENTIFIED BY 'access';" \
-e "GRANT ALL PRIVILEGES ON *.* TO 'access'@'%' WITH GRANT OPTION;" \
-e "ALTER USER 'access'@'%' IDENTIFIED WITH mysql_native_password BY 'access';" \
-e "FLUSH PRIVILEGES;"

## Comprobamos los privilegios en cada nodo
for N in 1 2 3
do docker compose exec node$N mysql -uroot -proot \
-e "SHOW VARIABLES WHERE Variable_name = 'hostname';" \
-e "SHOW GRANTS FOR 'access'@'%';"
done

### Metemos los Datos de ejemplo 

Accedemos a al nodo 1

docker compose exec node1 mysql -uroot -proot
```sql
use test;
-- Crear la tabla usuarios
CREATE TABLE usuarios (
id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(50),
edad INT,
email VARCHAR(100) UNIQUE
);

-- Insertar algunos datos de muestra
INSERT INTO usuarios (nombre, edad, email) VALUES
('Juan Pérez', 25, 'juan.perez@example.com'),
('María López', 30, 'maria.lopez@example.com'),
('Carlos Rodríguez', 22, 'carlos.rodriguez@example.com');
```

# Conectamos desde el HAProxy a través del puerto 3306
mysql -h 127.0.0.1 -P 3306 -u access -paccess -e "USE test; SELECT DATABASE(); SELECT @@hostname;"


mysql -h 127.0.0.1 -P 3306 -u access -paccess -e "SHOW TABLES FROM test;"

mysql -h 127.0.0.1 -P 3306 -u access -paccess -e "USE test; select * from usuarios;"

# Comprobamos que la replicación funciona, ejecutamos varias veces el comando anterior y veremos que el hostname va cambiando entre los nodos del cluster
# Comprobar Nodo 1
docker compose exec node1 mysql -uaccess -paccess test -e "SELECT 'NODO 1' as Nodo, COUNT(*) as Total FROM usuarios;"

# Comprobar Nodo 2
docker compose exec node2 mysql -uaccess -paccess test -e "SELECT 'NODO 2' as Nodo, COUNT(*) as Total FROM usuarios;"

# Comprobar Nodo 3
docker compose exec node3 mysql -uaccess -paccess test -e "SELECT 'NODO 3' as Nodo, COUNT(*) as Total FROM usuarios;"

# Comprobamos que la replicación funciona, ejecutamos varias veces el comando anterior y veremos que el hostname va cambiando entre los nodos del cluster
for N in 1 2 3; do
echo "--- Datos en node$N ---";
docker compose exec node$N mysql -uaccess -paccess test -e "SELECT @@hostname, id, nombre FROM usuarios;";
done
