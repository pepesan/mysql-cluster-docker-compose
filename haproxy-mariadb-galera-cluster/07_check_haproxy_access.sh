#!/bin/bash

mysql -h 127.0.0.1 -P 3306 -u testuser -piamgroot -e "SELECT @@hostname;"

for i in {1..6}; do mysql -h 127.0.0.1 -P 3306 -u testuser -piamgroot -N -s -e "SELECT @@hostname;"; done
