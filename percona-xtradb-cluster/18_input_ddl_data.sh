#!/bin/bash

mysql -h 127.0.0.1 -P 3306 -u root -p'test1234#' -e "
CREATE DATABASE IF NOT EXISTS fo_test;
USE fo_test;
CREATE TABLE IF NOT EXISTS t1 (
  id INT PRIMARY KEY AUTO_INCREMENT,
  msg VARCHAR(100)
);
INSERT INTO t1 (msg) VALUES ('antes del fallo');
SELECT @@hostname;
SELECT * FROM t1;
"
