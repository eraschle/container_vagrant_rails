#!/bin/bash

echo "*------------------------------------------------------------------------------"
echo "* EINRICHTEN DER APP '$APP_DIR'"
echo "*------------------------------------------------------------------------------"

cd $APP_DIR
bundle install
rbenv rehash

# echo ">> Ruby-Installation �eberpr�fen"
# curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash