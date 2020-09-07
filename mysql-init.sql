UPDATE mysql.user SET Host='%' WHERE User='root' AND Host='localhost';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host!='%';
FLUSH PRIVILEGES;
ALTER USER 'root'@'%' IDENTIFIED BY 'cloudreve';
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS cloudreve;


