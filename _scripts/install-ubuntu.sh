#!/bin/bash

echo "*------------------------------------------------------------------------------"
echo "* INSTALLATION VON LIBRARIES"
echo "*------------------------------------------------------------------------------"

apt-get -y update
apt-get -y install \
  git-core build-essential curl libcurl4-openssl-dev \
  zlib1g-dev libssl-dev liblzma-dev libreadline-dev libyaml-dev \
  sqlite3 libsqlite3-dev libxml2 libxml2-dev libxslt1-dev \
  python-software-properties libffi-dev nodejs \
  imagemagick libmagickwand-dev

# Needed for docs generation.
# update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8
# export LANGUAGE=en_US.UTF-8
# export LANG=en_US.UTF-8
# export LC_ALL=en_US.UTF-8
# locale-gen en_US.UTF-8
# dpkg-reconfigure locales