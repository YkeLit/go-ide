FROM ubuntu:latest

WORKDIR /root

COPY ./vimrc-init /root/.vimrc

COPY ./install.sh /usr/local
RUN chmod +x /usr/local/install.sh && /usr/local/install.sh

COPY ./vimrc /root/.vimrc
RUN cd /root/.vim/plugged/YouCompleteMe &&python3 install.py --go-completer --force-sudo
RUN apt-get clean && apt purge -y build-essential cmake python3-dev

CMD bash
