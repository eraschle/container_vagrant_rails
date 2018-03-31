#!/bin/bash

echo "*------------------------------------------------------------------------------"
echo "* INSTALLATION VON MYSQL '$VERSION'"
echo "*------------------------------------------------------------------------------"

echo mysql-server mysql-server/root_password select $ROOT_PW | debconf-set-selections
echo mysql-server mysql-server/root_password_again select $ROOT_PW | debconf-set-selections
apt-get -y install mysql-server-$VERSION mysql-client-$VERSION libmysqlclient-dev