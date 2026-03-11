#!/bin/bash
sleep 15
echo "Starting hotspot and docker containers..."
sudo hotspot-on
docker compose up -d
sleep 15 
source .venv/bin/activate
python3 start.py
