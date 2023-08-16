#!/bin/env bash

apt-get update && apt-get install wget curl git vim bash-completion tzdata exuberant-ctags -y &>> /dev/null && \
	apt-get autoremove -y && \
	rm -rf /var/lib/apt/lists/* && \
	ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime && \
	echo ${TZ} > /etc/timezone && \
	dpkg-reconfigure --frontend noninteractive tzdata
	
wget https://dl.google.com/go/go1.20.3.linux-arm64.tar.gz &>> /dev/null &&\
	tar xzvf go1.20.3.linux-arm64.tar.gz -C /usr/local/ >>/dev/null &&\
	rm -f go1.20.3.linux-arm64.tar.gz

mkdir -p $HOME/go/{bin,pkg,src}

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim -c PlugInstall -c q -c q
