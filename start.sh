#!/bin/bash
sleep 15
echo "Starting hotspot and docker containers..."
sudo hotspot-on
docker compose up -d
sleep 15 
source /home/syntra/Documents/Syntra-Config/.venv/bin/activate
python3 /home/syntra/Documents/Syntra-Config/start.py
