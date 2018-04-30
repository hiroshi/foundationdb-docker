# foundationdb-docker
A docker file for FoundationDB


Start FoundationDB server as a docker container.

```
$ docker run --init --rm --name=fdb -h fdb -v fdb:/fdb -e FDB_CLUSTER_FILE=/fdb/fdb.cluster hiroshi3110/foundationdb:5.1.5-1_ubuntu-16.04 sh start.sh
```

Connect the server container from other container.

```
$ docker run --rm -ti -v fdb:/etc/foundationdb hiroshi3110/foundationdb:5.1.5-1_ubuntu-16.04 fdbcli
fdb> status
...
```
