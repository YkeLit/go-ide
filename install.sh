#!/bin/env bash

apt update && apt install wget curl git vim  build-essential cmake python3-dev -y

wget https://dl.google.com/go/go1.20.3.linux-amd64.tar.gz
tar xzvf go1.20.3.linux-amd64.tar.gz -C /usr/local/

echo "export PATH=$PATH:/usr/local/go/bin" >> /root/.bashrc
echo export LC_ALL="C.UTF-8" >> /root/.bashrc
mkdir -p $HOME/go/{bin,pkg,src}

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim -c PlugInstall -c q -c q
vim -c GoInstallBinaries -c q -c q

cd /root/.vim/plugged/YouCompleteMe &&python3 install.py --go-completer --force-sudo
