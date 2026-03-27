#!/bin/bash

mysql -h 127.0.0.1 -P 3306 -u root  -p'test1234#' -e "
SHOW STATUS LIKE 'wsrep_cluster_size';
SHOW STATUS LIKE 'wsrep_cluster_status';
SHOW STATUS LIKE 'wsrep_local_state_comment';
SHOW STATUS LIKE 'wsrep_ready';
SHOW STATUS LIKE 'wsrep_incoming_addresses';
"