FROM ubuntu:latest

COPY ./install.sh /usr/local
COPY ./vimrc /root/.vimrc

WORKDIR /root

RUN chmod +x /usr/local/install.sh && /usr/local/install.sh

CMD bash
