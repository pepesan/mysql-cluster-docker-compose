#!/bin/bash

mysql -h 127.0.0.1 -P 13306 -u root -piamgroot \
    -e "show status like 'wsrep_%';" \
    -e "show status like  'wsrep_incoming_addresses';" \
    -e "SHOW STATUS LIKE 'wsrep_cluster_size';"