#!/bin/bash
cp hatdog.service /etc/systemd/system/hatdog.service
chmod +x start.sh
sudo systemctl daemon-reload
sudo systemctl enable hatdog
sudo systemctl hatdog 
