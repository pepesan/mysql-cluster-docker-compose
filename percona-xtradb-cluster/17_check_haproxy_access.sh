#!/bin/bash

mysql -h 127.0.0.1 -P 3306 -u root  -p'test1234#' -e "SELECT @@hostname;"

for i in {1..6}; do mysql -h 127.0.0.1 -P 3306 -u root  -p'test1234#' -N -s -e "SELECT @@hostname;"; done
