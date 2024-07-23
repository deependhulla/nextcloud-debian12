#!/bin/bash

apt update
apt -y -qq upgrade

CFG_HOSTNAME_FQDN=`hostname -f`
echo "postfix postfix/main_mailer_type select Internet Site" | debconf-set-selections
echo "postfix postfix/mailname string $CFG_HOSTNAME_FQDN" | debconf-set-selections
echo "iptables-persistent iptables-persistent/autosave_v4 boolean true" | debconf-set-selections
echo "iptables-persistent iptables-persistent/autosave_v6 boolean true" | debconf-set-selections
DEBIAN_FRONTEND=noninteractive

apt -y  install vim chrony openssh-server screen net-tools git mc postfix sendemail  \
sudo wget curl ethtool iptraf-ng traceroute telnet rsyslog software-properties-common \
iputils-ping  psmisc apt-transport-https elinks xfsprogs debconf-utils pwgen ca-certificates \
gnupg2  unzip zip tree htop ffmpeg ghostscript libfile-fcntllock-perl apache2 php php-zip \
rsync php-zip php-mysql php-cli php-common php-imap php-ldap php-xml tar \
php-curl php-mbstring php-zip php-apcu php-gd php-imagick imagemagick mcrypt \
memcached php-memcached php-bcmath dbconfig-common libapache2-mod-php php-intl \
php-mailparse automysqlbackup php-mail-mime sendemail mariadb-server php-pear  


systemctl restart chrony
echo > /var/log/mail.log
/bin/rm -rf /var/log/mail.info
/bin/rm -rf /var/log/mail.warn
/bin/rm -rf /var/log/mail.err

a2enmod actions > /dev/null 2>&1
a2enmod proxy_fcgi > /dev/null 2>&1
a2enmod fcgid > /dev/null 2>&1
a2enmod alias > /dev/null 2>&1
a2enmod suexec > /dev/null 2>&1
a2enmod rewrite > /dev/null 2>&1
a2enmod ssl > /dev/null 2>&1
a2enmod actions > /dev/null 2>&1
a2enmod include > /dev/null 2>&1
a2enmod dav_fs > /dev/null 2>&1
a2enmod dav > /dev/null 2>&1
a2enmod auth_digest > /dev/null 2>&1
a2enmod cgi > /dev/null 2>&1
a2enmod headers > /dev/null 2>&1
a2enmod proxy_http > /dev/null 2>&1


### changing timezone to Asia Kolkata
sed -i "s/;date.timezone =/date\.timezone \= \'Asia\/Kolkata\'/" /etc/php/8.2/apache2/php.ini
sed -i "s/;date.timezone =/date\.timezone \= \'Asia\/Kolkata\'/" /etc/php/8.2/cli/php.ini
#sed -i "s/;date.timezone =/date\.timezone \= \'Asia\/Kolkata\'/" /etc/php/8.2/fpm/php.ini
##disable error
sed -i "s/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ERROR/" /etc/php/8.2/cli/php.ini
#sed -i "s/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ERROR/" /etc/php/8.2/fpm/php.ini
sed -i "s/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ERROR/" /etc/php/8.2/apache2/php.ini

sed -i "s/memory_limit = 128M/memory_limit = 512M/" /etc/php/8.2/apache2/php.ini
sed -i "s/post_max_size = 100M/post_max_size = 800M/" /etc/php/8.2/apache2/php.ini
sed -i "s/post_max_size = 8M/post_max_size = 800M/" /etc/php/8.2/apache2/php.ini
sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 100M/" /etc/php/8.2/apache2/php.ini
systemctl restart apache2
systemctl restart  mariadb

##disable this program as not needed
systemctl stop ModemManager 1>/dev/null 2>/dev/null
systemctl disable ModemManager 1>/dev/null 2>/dev/null
systemctl stop wpa_supplicant 1>/dev/null 2>/dev/null
systemctl disable wpa_supplicant 1>/dev/null 2>/dev/null


