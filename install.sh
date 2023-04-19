#!/bin/env bash

apt-get update && apt-get install wget curl git vim  build-essential cmake python3-dev -y &>> /dev/null

wget https://dl.google.com/go/go1.20.3.linux-amd64.tar.gz &>> /dev/null &&\
	tar xzvf go1.20.3.linux-amd64.tar.gz -C /usr/local/ >>/dev/null &&\
	rm -f go1.20.3.linux-amd64.tar.gz

echo "export PATH=$PATH:/usr/local/go/bin" >> /root/.bashrc &&\
	echo export LC_ALL="C.UTF-8" >> /root/.bashrc &&\
	export PS1='\n\e[1;37m[\e[m\e[1;32m\h\e[m\e[1;33m@\e[m\e[1;35m\u\e[m \e[4m\w\e[m\e[1;37m] \[\e[1;33mWORK\e \e[m\e[1;36m\e[m\n\$'

ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo 'Asia/Shanghai' >/etc/timezone
mkdir -p $HOME/go/{bin,pkg,src}

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim -c PlugInstall -c q -c q

