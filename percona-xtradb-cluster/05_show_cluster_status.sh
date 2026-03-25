#!/bin/bash

docker exec -it pxc-node1 mysql -u root -p'test1234#' -e "show status like 'wsrep%';"