var dbPass = "mysql"
var clusterName = "devCluster"

print('Setting up InnoDB cluster...\n');
shell.connect('root@mysql-server-1:3306', dbPass)
var cluster = dba.createCluster(clusterName);
print('Adding instances to the cluster.');
cluster.addInstance({user: "root", host: "mysql-server-2", password: dbPass}, {recoveryMethod:"clone"})
// reinicia el servidor mysql-server-2
// docker compose start mysql-server-2
print('.');
cluster.addInstance({user: "root", host: "mysql-server-3", password: dbPass}, {recoveryMethod:"clone"})
// reinicia el servidor mysql-server-3
// docker compose start mysql-server-3
print('.\nInstances successfully added to the cluster.');
print('\nInnoDB cluster deployed successfully.\n');

