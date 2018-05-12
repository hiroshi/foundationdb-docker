# foundationdb-docker
A docker file for FoundationDB.


## Start a FoundationDB server in a docker container.

```
$ docker run --init --rm --name=fdb-0 -v fdb-0:/var/lib/foundationdb hiroshi3110/foundationdb:5.1.5-1_ubuntu-16.04 ./start.sh
```

If /var/lib/foundationdb/data/4500 directory is empty, it will configure new cluster.

## Join a server to the cluster

```
$ docker run --init --rm --name=fdb-1 -v fdb-1:/var/lib/foundationdb hiroshi3110/foundationdb:5.1.5-1_ubuntu-16.04 ./start.sh $(docker exec fdb-0 cat /etc/foundationdb/fdb.cluster)
```
