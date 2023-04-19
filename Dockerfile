FROM ubuntu:latest

COPY ./vimrc-init /root/.vimrc

COPY ./install.sh /usr/local
RUN chmod +x /usr/local/install.sh && /usr/local/install.sh

ENV PATH /usr/local/go/bin:$PATH
RUN vim -c GoInstallBinaries -c q -c q && cd /root/.vim/plugged/YouCompleteMe &&python3 install.py --go-completer --force-sudo

COPY ./vimrc /root/.vimrc
RUN apt-get clean -y && apt autoremove -y && apt purge -y build-essential cmake python3-dev

ENV GOPATH /root/go
ENV PATH $GOPATH/bin:$PATH
RUN chmod -R 1777 "$GOPATH" && rm -rf /root/go/pkg/* /root/.cache/* /root/.vim/plugged/YouCompleteMe/.git
WORKDIR $GOPATH
