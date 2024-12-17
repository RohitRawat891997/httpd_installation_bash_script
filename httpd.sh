#!/bin/bash
sudo  yum install -y httpd
sudo  systemctl  start  httpd
sudo  systemctl  enable  httpd
sed -i   's/^Listen 80/Listen 8080/g'  /etc/httpd/conf/httpd.conf
echo "hi"  >  /var/www/html/index.html
