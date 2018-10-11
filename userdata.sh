#!/bin/sh
set -x
# output log of userdata to /var/log/user-data.log
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console)
yum install -y httpd
service httpd start
chconfig httpd on
echo "<html><h1> Hello From Harini</h1></html>" > /var/www/html/index.htm
