# Ejemplo de despliegue de MySQL InnoDB Cluster con MySQL Shell y MySQL Router

## Despliegue
docker compose up -d
## Parada
docker compose down
## Acceso al MySQL Router
mysql -h 127.0.0.1 -P 6446 -u root -pmysql