#!/bin/bash
# Create required s6 runtime directories
mkdir -p /var/run/s6/services/s6-fdholderd/supervise
chown -R container:container /mnt/server
# You may add more directories if other services fail, but start with this.
exec /init
