#!/bin/bash
sleep 15
echo "Starting hotspot and docker containers..."
sudo hotspot-off
sudo hotspot-on
docker compose up -d
sleep 15
sudo -u syntra DISPLAY=:0 XAUTHORITY=/home/syntra.XAuthority .venv/bin/python3 /home/syntra/Documents/Syntra-Config/start.py
