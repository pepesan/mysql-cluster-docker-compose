#!/bin/bash

mysql -h 127.0.0.1 -P 3306 -u root  -p'test1234#' -e "
USE fo_test;
INSERT INTO t1 (msg) VALUES ('dato antes de levantar node1');
SELECT * FROM t1;
"