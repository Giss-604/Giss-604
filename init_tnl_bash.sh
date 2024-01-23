##!/usr/bin/env sh

if [ -r "${HOME}/.bashrc" ]; then
	rm -rf ${HOME}/.bashrc
fi
rm -rf ${HOME}/BASH_HOME
rm ~/.gitconfig
rm ~/.gitignore

# git clone git@github.com:Giss-604/tnl.git ~/BASH_HOME_4git

start=0
if [ $? -eq 0 ]; then
	ln -sf ${HOME}/BASH_HOME_4git/BASH_HOME ~/BASH_HOME
	ln -sf ${HOME}/BASH_HOME/DOT_DIR/bashrc ~/.bashrc
	ln -sf ${HOME}/BASH_HOME/DOT_DIR/gitconfig ~/.gitconfig
	ln -sf ${HOME}/BASH_HOME/DOT_DIR/gitignore ~/.gitignore

fi
