#!/bin/bash

echo "*------------------------------------------------------------------------------"
echo "* INSTALLATION VON RUBY '$RUBY_VERSION'"
echo "*------------------------------------------------------------------------------"

if [[ ! -d $HOME/.rbenv ]]; then
  git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"'  >> $HOME/.bash_profile
  echo 'eval "$(rbenv init -)"'                >> $HOME/.bash_profile
  source $HOME/.bash_profile
fi

if [[ ! -d $HOME/.rbenv/plugins/ruby-build ]]; then
  git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build
  echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> $HOME/.bash_profile
  source $HOME/.bash_profile
fi

source $HOME/.bash_profile
rbenv install --skip-existing $RUBY_VERSION

rbenv global $RUBY_VERSION
echo "*** 'System Ruby-Version '$RUBY_VERSION'"

cd $APP_DIR
rbenv local $RUBY_VERSION
echo "*** 'Local Ruby-Version '$RUBY_VERSION' '$APP_DIR'"

gem install bundler
rbenv rehash