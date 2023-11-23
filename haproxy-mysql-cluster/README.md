# haproxy-mysql

## Create haproxy user
CREATE USER 'haproxy_user'@'%' IDENTIFIED BY '';
GRANT ALL PRIVILEGES ON *.* TO 'haproxy_user'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

## Create access user
CREATE USER 'test'@'%' IDENTIFIED BY 'test';
GRANT ALL PRIVILEGES ON *.* TO 'test'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
