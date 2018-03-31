#!/bin/bash

function IsNewerVersion {
  if [[ $1 == $SYSTEM_RUBY ]]; then
    return 1
  fi
  local IFS=.
  local i ver1=($1) ver2=($SYSTEM_RUBY)
  # fill empty fields in ver1 with zeros
  for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
  do
    ver1[i]=0
  done
  
  for ((i=0; i<${#ver1[@]}; i++))
  do
    if [[ -z ${ver2[i]} ]]; then
    # fill empty fields in ver2 with zeros
      ver2[i]=0
    fi
    if ((10#${ver1[i]} > 10#${ver2[i]})); then
      return 0
    fi
  done
  return 1
}

echo "*------------------------------------------------------------------------------"
echo "* INSTALLATION VON RUBY '$RUBY_VERSION'"
echo "*------------------------------------------------------------------------------"

if [ ! -d $HOME/.rbenv ]; then
  echo "*** Installiere RBENV ***"
  git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $HOME/.bash_profile
  echo 'eval "$(rbenv init -)"'               >> $HOME/.bash_profile
  source $HOME/.bash_profile
fi

if [ ! -d $HOME/.rbenv/plugins/ruby-build ]; then
  echo "*** Installiere Ruby-Build ***"
  git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build
  echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> $HOME/.bash_profile
  source $HOME/.bash_profile
fi

rbenv install --skip-existing $RUBY_VERSION

# System Ruby aktualisieren, wenn 
# die aktuelle Ruby-Version neuer ist als die aktuelle System-Version
if [ $(IsNewerVersion $RUBY_VERSION ) ]; then
  rbenv global $RUBY_VERSION
  echo "*** System Ruby ('$RUBY_VERSION') gesetzt ***"
fi


# Locale Ruby installieren, wenn noch keine .ruby-version-Datei vorhanden ist
if [ ! -f $APP_DIR/.ruby-version ]; then
  cd $APP_DIR
  rbenv local $RUBY_VERSION
  echo "*** Local Ruby ('$RUBY_VERSION') gesetzt ***"
fi

# Nachdem Ruby installiert wurde kann Bundler installiert werden
gem install bundler # 1>/dev/null 2>&1
rbenv rehash
BUNDLE_VERSION=$(bundle version)
echo "** Bundle '$BUNDLE_VERSION' installiert"