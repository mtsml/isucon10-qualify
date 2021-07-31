#!/bin/sh

# mysql
now=`date +%Y%m%d%H%M%S`
sudo mv /var/log/mysql/mysql-slow.log /var/log/mysql/mysql-slow.log.$now
