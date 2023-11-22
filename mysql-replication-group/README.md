# Mysql Replication Group
docker compose up -d

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
## Create haproxy user
for N in 1 2 3
do docker compose exec node$N mysql -uroot -proot \
-e "CREATE USER 'haproxy_user'@'%' IDENTIFIED BY '';" \
-e "ALTER USER 'haproxy_user'@'%' IDENTIFIED WITH mysql_native_password BY '';" \
-e "GRANT ALL PRIVILEGES ON *.* TO 'haproxy_user'@'%' WITH GRANT OPTION;" \
-e "FLUSH PRIVILEGES;"
done


#### via consola
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
### Create access user
docker compose exec node1 mysql -uroot -proot \
-e "CREATE USER 'access'@'%' IDENTIFIED BY 'access';" \
-e "GRANT ALL PRIVILEGES ON *.* TO 'test'@'%' WITH GRANT OPTION;" \
-e "FLUSH PRIVILEGES;"

## Comprobamos los privilegios en cada nodo
for N in 1 2 3
do docker compose exec node$N mysql -uroot -proot \
-e "SHOW VARIABLES WHERE Variable_name = 'hostname';" \
-e "SHOW GRANTS FOR 'access'@'%';"
done

### Datos de ejemplo
```sql
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



