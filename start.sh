#!/bin/bash
sleep 15
echo "Starting hotspot and docker containers..."
sudo hotspot-on
docker compose up -d
