#!/bin/bash

for i in {1..6}; do
  mysql -h 127.0.0.1 -P 6447 -u root -pmysql -N -s -e "SELECT @@hostname";
done