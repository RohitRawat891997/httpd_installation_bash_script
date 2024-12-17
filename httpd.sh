#!/bin/bash
sudo  yum install -y httpd
sudo  systemctl  start  httpd
sudo  systemctl  enable  httpd
echo "hi"  >  /var/www/html/index.html
