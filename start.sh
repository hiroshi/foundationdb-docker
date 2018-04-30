mv /etc/foundationdb/fdb.cluster /fdb/fdb.cluster
IP=$(getent hosts $(hostname) | cut -d ' ' -f1)
sed -i \
    -e "s/\(public_address = \).*/\1$IP:\$ID/" \
    -e 's/\(listen_address = \).*/\10.0.0.0:$ID/' \
    -e 's/\(cluster_file = \).*/\1\/fdb\/fdb.cluster/' \
    /etc/foundationdb/foundationdb.conf

(sleep 1 && fdbcli -C /fdb/fdb.cluster --exec "coordinators $IP:4500" &)
exec /usr/lib/foundationdb/fdbmonitor
