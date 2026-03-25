#!/bin/bash

docker exec -it pxc-node2 mysql -u root -p'test1234#' -e "show status like 'wsrep%';"