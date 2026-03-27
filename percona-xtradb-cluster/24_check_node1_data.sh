#!/bin/bash

docker compose exec pxc-node1 mysql -uroot -p'test1234#' -e "
SHOW STATUS LIKE 'wsrep_local_state_comment';
SHOW STATUS LIKE 'wsrep_cluster_size';
USE fo_test;
SELECT @@hostname;
SELECT * FROM t1;
"