#!/bin/bash

cd /tmp/
#wget -c https://download.nextcloud.com/server/releases/latest.tar.bz2
#tar -xvjf latest.tar.bz2 
mkdir /home/nextcloud-data
chown -R www-data:www-data /home/nextcloud-data

mv -v /var/www/html /var/www/old-html-`date +%s`
mv -v /tmp/nextcloud /var/www/html
chown -R www-data:www-data /var/www/html
cd -

