#!/bin/sh
/usr/bin/nodejs /opt/core/server.js \
    --listen 0.0.0.0 \
    --port 8181 \
    -a $USERNAME:$PASSWORD \
-w /home/user/workspace
