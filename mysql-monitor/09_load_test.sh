#!/usr/bin/env bash
set -euo pipefail

HOST="127.0.0.1"
PORT="3306"
USER="root"
PASS="root"
DB="test"
TABLE="carga_test"

echo "Creando tabla si no existe..."

mysql -h "$HOST" -P "$PORT" -u "$USER" -p"$PASS" "$DB" <<SQL
CREATE TABLE IF NOT EXISTS $TABLE (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  payload VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);
SQL

echo "Insertando 1 registro por segundo en $DB.$TABLE"
echo "Pulsa Ctrl+C para parar"

i=1
while true; do
  mysql -h "$HOST" -P "$PORT" -u "$USER" -p"$PASS" "$DB" \
    -e "INSERT INTO $TABLE (payload) VALUES ('registro $i');"
  echo "Insertado registro $i"
  i=$((i+1))
  sleep 1
done