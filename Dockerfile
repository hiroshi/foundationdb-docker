FROM ubuntu:16.04
RUN apt-get update && apt-get install -y curl python
WORKDIR /root
RUN curl -sO https://www.foundationdb.org/downloads/5.1.5/ubuntu/installers/foundationdb-clients_5.1.5-1_amd64.deb
RUN curl -sO https://www.foundationdb.org/downloads/5.1.5/ubuntu/installers/foundationdb-server_5.1.5-1_amd64.deb
RUN dpkg -i foundationdb-clients_5.1.5-1_amd64.deb foundationdb-server_5.1.5-1_amd64.deb

ADD start.sh ./
