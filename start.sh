#!/bin/sh
if [ ! -d /var/lib/foundationdb/data/4500 ]
then
    if [ "$1" = "" ]
    then
      echo "Configure new cluster."
       /usr/lib/foundationdb/make_public.py
       (sleep 1 && fdbcli --no-status --exec "configure new single memory" &)
    else
      echo "Replace /etc/foundationdb/fdb.cluster with $1 to join."
      echo $1 > /etc/foundationdb/fdb.cluster
    fi
fi
exec /usr/lib/foundationdb/fdbmonitor
