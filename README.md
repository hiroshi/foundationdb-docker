# foundationdb-docker
A docker file for FoundationDB


Using `fdb` docker image.

Start FoundationDB server as a docker container.

```
$ docker run --init --rm --name=fdb -h fdb -v fdb:/fdb -e FDB_CLUSTER_FILE=/fdb/fdb.cluster fdb sh start.sh
```

Connect the server container from other container.

```
$ docker run --rm -ti -v fdb:/etc/foundationdb fdb fdbcli
fdb> status
...
```
