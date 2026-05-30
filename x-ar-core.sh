#!/bin/bash
source /opt/x-ar/x-ar.conf
echo "Running..."
while true
do
    x-ui restart-xray
    sleep "$INTERVAL"
done