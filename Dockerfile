FROM ubuntu:16.04
RUN apt-get update && apt-get install -y curl python
WORKDIR /root
RUN curl -sO https://www.foundationdb.org/downloads/5.1.7/ubuntu/installers/foundationdb-clients_5.1.7-1_amd64.deb
RUN curl -sO https://www.foundationdb.org/downloads/5.1.7/ubuntu/installers/foundationdb-server_5.1.7-1_amd64.deb
RUN dpkg -i foundationdb-clients_5.1.7-1_amd64.deb foundationdb-server_5.1.7-1_amd64.deb

ADD start.sh ./
# Add tini for pre Docker 1.13 environment or kubernetes
ADD https://github.com/krallin/tini/releases/download/v0.18.0/tini .
RUN chmod a+x tini
