##!/usr/bin/env sh

if [ -r "${HOME}/.bashrc" ]; then
  rm -rf ${HOME}/.bashrc
fi
rm -rf ${HOME}/BASH_HOME

git clone git@github.com:Giss-604/tnl.git ~/BASH_HOME_4git 
if [ $? -eq 0 ]; then
  ln -sf ${HOME}/BASH_HOME_4git/BASH_HOME ~/BASH_HOME
  ln -sf ${HOME}/BASH_HOME/DOT_DIR/bashrc ~/.bashrc
fi
