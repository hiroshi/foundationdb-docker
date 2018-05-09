IP=$(getent hosts $(hostname) | cut -d ' ' -f1)
sed -i \
    -e "s/\(public_address = \).*/\1$IP:\$ID/" \
    -e 's/\(listen_address = \).*/\10.0.0.0:$ID/' \
    /etc/foundationdb/foundationdb.conf

(sleep 1 && fdbcli --exec "coordinators $IP:4500" &)
exec /usr/lib/foundationdb/fdbmonitor
