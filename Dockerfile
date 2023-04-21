FROM ubuntu:latest

COPY ./vimrc-init /root/.vimrc
COPY ./bashrc /root/.bashrc
COPY ./install.sh /usr/local

ENV TZ=Asia/Shanghai \
    DEBIAN_FRONTEND=noninteractive
    
RUN chmod +x /usr/local/install.sh && /usr/local/install.sh &&\
    rm -fr /root/.vim/plugged/YouCompleteMe/.git

ENV PATH /usr/local/go/bin:$PATH

RUN apt-get update && apt-get install -y build-essential cmake python3-dev &&\
    vim -c GoInstallBinaries -c q -c q &&\
    cd /root/.vim/plugged/YouCompleteMe &&\
    python3 install.py --go-completer --force-sudo &&\
    apt purge -y build-essential cmake python3-dev &&\
    apt autoremove -y &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /root/go/pkg/* /root/.cache/*

ENV GOPATH /root/go
ENV PATH $GOPATH/bin:$PATH
    
COPY ./vimrc /root/.vimrc

WORKDIR $GOPATH
