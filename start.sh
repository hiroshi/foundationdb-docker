#!/bin/sh
if [ ! -f /var/lib/foundationdb/fdb.cluster ]
then
    if [ "$1" = "" ]
    then
        echo "Configure new cluster."
        /usr/lib/foundationdb/make_public.py
        cp /etc/foundationdb/fdb.cluster /var/lib/foundationdb/fdb.cluster
        (sleep 1 && fdbcli --no-status --exec "configure new single memory" &)
    else
        echo "Replace $FDB_CLUSTER_FILE with $1 to join."
        echo $1 > /var/lib/foundationdb/fdb.cluster
    fi
fi
exec /usr/lib/foundationdb/fdbmonitor
