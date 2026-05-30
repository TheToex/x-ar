#!/bin/bash

set -e

echo "Installing X-AR..."

mkdir -p /opt/x-ar

cp x-ar.conf /opt/x-ar/
cp x-ar-core.sh /opt/x-ar/
cp x-ar-panel.sh /opt/x-ar/

chmod +x x-ar-panel.sh
chmod +x x-ar-core.sh

cp x-ar /usr/local/bin/
chmod +x /usr/local/bin/x-ar

cp x-ar.service /etc/systemd/system/

systemctl daemon-reload
systemctl enable x-ar
systemctl restart x-ar

echo "Installation completed successfully."