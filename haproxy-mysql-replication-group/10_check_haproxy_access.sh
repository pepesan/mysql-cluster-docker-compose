#!/bin/bash

mysql -h 127.0.0.1 -P 3306 -u access -paccess -e "USE test; SELECT DATABASE(); SELECT @@hostname;"

mysql -h 127.0.0.1 -P 3306 -u access -paccess -e "SHOW TABLES FROM test;"

mysql -h 127.0.0.1 -P 3306 -u access -paccess -e "USE test; select * from usuarios;"