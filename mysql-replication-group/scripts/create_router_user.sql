CREATE USER 'router'@'%' IDENTIFIED BY 'router';
GRANT ALL PRIVILEGES ON *.* TO 'router'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
