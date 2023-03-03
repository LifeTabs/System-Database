CREATE USER maxscale@'%' IDENTIFIED BY 'Lif3T@b';
GRANT SELECT ON mysql.* TO maxscale@'%';
GRANT SHOW DATABASES, SLAVE MONITOR ON *.* TO maxscale@'%';
GRANT ALL PRIVILEGES ON *.* TO `maxscale`@`%`

SET GLOBAL general_log=1;