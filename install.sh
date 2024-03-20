#!/bin/env bash

ARCH=$(dpkg --print-architecture)
VERSION=1.21.8

apt-get update && apt-get install wget curl git vim bash-completion tzdata exuberant-ctags -y &>> /dev/null && \
	apt-get autoremove -y && \
	rm -rf /var/lib/apt/lists/* && \
	ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime && \
	echo ${TZ} > /etc/timezone && \
	dpkg-reconfigure --frontend noninteractive tzdata
	
wget https://dl.google.com/go/go$VERSION.linux-$ARCH.tar.gz &>> /dev/null &&\
	tar xzvf go$VERSION.linux-$ARCH.tar.gz -C /usr/local/ >>/dev/null &&\
	rm -f go$VERSION.linux-$ARCH.tar.gz

mkdir -p $HOME/go/{bin,pkg,src}

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall +qall
