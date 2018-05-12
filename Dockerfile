FROM ubuntu:16.04
RUN apt-get update && apt-get install -y python
WORKDIR /root
ADD https://www.foundationdb.org/downloads/5.1.5/ubuntu/installers/foundationdb-clients_5.1.5-1_amd64.deb .
ADD https://www.foundationdb.org/downloads/5.1.5/ubuntu/installers/foundationdb-server_5.1.5-1_amd64.deb .
RUN dpkg -i foundationdb-clients_5.1.5-1_amd64.deb foundationdb-server_5.1.5-1_amd64.deb
# https://forums.foundationdb.org/t/how-to-add-a-server-container-to-a-cluster/394/2
# https://forums.foundationdb.org/t/simple-dockerfile/280/5
RUN rm -r /var/lib/foundationdb/data/*

# Add tini for pre Docker 1.13 environment or kubernetes
ADD https://github.com/krallin/tini/releases/download/v0.18.0/tini .
RUN chmod a+x tini

ADD start.sh ./
ADD foundationdb.conf /etc/foundationdb/foundationdb.conf
