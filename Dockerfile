FROM ubuntu:latest

COPY ./vimrc-init /root/.vimrc
COPY ./bashrc /root/.bashrc

COPY ./install.sh /usr/local
RUN chmod +x /usr/local/install.sh && /usr/local/install.sh && \
	rm -fr /root/.vim/plugged/YouCompleteMe/.git

ENV PATH /usr/local/go/bin:$PATH
RUN  apt-get update && apt-get install -y build-essential cmake python3-dev && \
	rm -rf /var/lib/apt/lists/* && \
	vim -c GoInstallBinaries -c q -c q && \
	cd /root/.vim/plugged/YouCompleteMe &&\
	python3 install.py --go-completer --force-sudo && \
	apt autoremove -y && \
	apt purge -y build-essential cmake python3-dev && \
	rm -rf /root/go/pkg/* /root/.cache/*

COPY ./vimrc /root/.vimrc

ENV GOPATH /root/go
ENV PATH $GOPATH/bin:$PATH
ENV TZ=Asia/Shanghai \
    DEBIAN_FRONTEND=noninteractive

RUN apt update \
    && apt install -y tzdata \
    && ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && rm -rf /var/lib/apt/lists/*
RUN chmod -R 1777 "$GOPATH"
WORKDIR $GOPATH
