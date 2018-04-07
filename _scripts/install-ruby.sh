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

## Gems zum Programmieren, Debugen, Testen installieren, 
## sofern diese nicht bereits für RUBY_VERSION installiert worden ist
# Needed gems
GEMPATH=$HOME/.rbenv/versions/$RUBY_VERSION/lib/ruby/gems/$RUBY_VERSION/gems
if [ $(find $GEMPATH -name 'bundler*' -mmin -5 | wc -l) -eq 0 ]; then
  echo "*** 'Install bundler and rails"
  gem install bundler rails --no-ri
fi

# Debug-Gems
if [ $(find $GEMPATH -name 'rubocop*' -mmin -5 | wc -l) -eq 0 ]; then
  echo "*** 'Install gems for debuging"
  gem install rubocop:0.52.0 debase ruby-debug-ide --no-ri
fi

# Testing-Gems
  echo "*** 'Install gems for testing"
if [ $(find $GEMPATH -name 'ZenTest*' -mmin -5 | wc -l) -eq 0 ]; then
  gem install ZenTest rspec rspec-rails --no-ri
fi
rbenv rehash