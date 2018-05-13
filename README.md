# foundationdb-docker
A docker file for FoundationDB.


## Docker
### Start a FoundationDB server in a docker container.

```
$ docker run --init --rm --name=fdb-0 -v fdb-0:/var/lib/foundationdb hiroshi3110/foundationdb:5.1.5-1_ubuntu-16.04 ./start.sh
```

If /var/lib/foundationdb/data/4500 directory is empty, it will configure new cluster.

### Join a server to the cluster

```
$ docker run --init --rm --name=fdb-1 -v fdb-1:/var/lib/foundationdb hiroshi3110/foundationdb:5.1.5-1_ubuntu-16.04 ./start.sh $(docker exec fdb-0 cat /var/lib/foundationdb/fdb.cluster)
```

### Open a fdbcli session

You can run `fdbcli` on any server containers,
```
$ docker exec -ti fdb-0 fdbcli -C /var/lib/foundationdb/fdb.cluster
```

or run as a new container.
```
docker run -ti --rm -v fdb-0:/etc/foundationdb hiroshi3110/foundationdb:5.1.5-1_ubuntu-16.04 fdbcli
```

## Kubernetes

A sample StatefulSet configuration.

```
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: foundationdb
spec:
  selector:
    matchLabels:
      app: foundationdb
  serviceName: foundationdb
  template:
    metadata:
      labels:
        app: foundationdb
    spec:
      initContainers:
      - name: copy-fdb-cluster
        image: google/cloud-sdk
        command: ["sh", "-c", "if [ $HOSTNAME != foundationdb-0 ]; then kubectl exec foundationdb-0 cat /var/lib/foundationdb/fdb.cluster | tee /fdb/fdb.cluster; fi"]
        volumeMounts:
        - name: var-lib-fdb
          mountPath: "/fdb"
      containers:
      - name: foundationdb
        image: hiroshi3110/foundationdb:5.1.5-1_ubuntu-16.04
        imagePullPolicy: Always
        command: ["/root/tini"]
        args: ["--", "/root/start.sh"]
        ports:
        - containerPort: 4500
          name: fdb
        volumeMounts:
        - name: var-lib-fdb
          mountPath: "/var/lib/foundationdb"
      volumes:
      - name: var-lib-fdb
        emptyDir: {}
```

To put `/etc/foundationdb/fdb.cluster` in your own pod, initContainer like this may help.
```
      initContainers:
      - name: copy-fdb-cluster
        image: google/cloud-sdk
        command: ["sh", "-c", "kubectl exec foundationdb-0 cat /var/lib/foundationdb/fdb.cluster > /fdb/fdb.cluster"]
        volumeMounts:
        - name: fdb-cluster
          mountPath: "/fdb"
      containers:
        ...
        volumeMounts:
        - name: fdb-cluster
          mountPath: "/etc/foundationdb/fdb.cluster"
          subPath: "fdb.cluster"
      volumes:
      - name: fdb-cluster
        emptyDir: {}
```
