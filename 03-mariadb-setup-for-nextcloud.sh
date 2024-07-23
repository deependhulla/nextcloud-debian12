#!/bin/bash



MYSQLPASSVPOP=`pwgen -c -1 8`
echo $MYSQLPASSVPOP > /usr/local/src/mariadb-nextadmin-pass
echo "mydbadmin password in /usr/local/src/mariadb-nextadmin-pass"

echo "GRANT ALL PRIVILEGES ON *.* TO nextadmin@localhost IDENTIFIED BY '$MYSQLPASSVPOP'" with grant option | mysql -uroot
echo "create database nextclouddb " | mysql -uroot
mysqladmin -uroot reload
mysqladmin -uroot refresh

systemctl restart  mariadb

#mysqladmin -u root -ptmppassword status
#mysqladmin -u root -p extended-status
#mysqladmin -u root -p processlist

echo "Database Password Setup done."
