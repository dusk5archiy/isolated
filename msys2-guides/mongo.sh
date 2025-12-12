cat >$TMP/mongod.cfg <<EOF
storage:
    dbPath: $HOME_DRIVE_LETTER:\\host\\db
net:
    bindIp: localhost
    port: 27017
EOF

mongod -f $TMP/mongod.cfg
