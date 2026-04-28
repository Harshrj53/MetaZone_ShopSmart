#!/bin/bash

# Pull latest code (if using git)
# git pull origin main

# Build and restart containers
docker-compose down
docker-compose up --build -d

# Check status
docker-compose ps
