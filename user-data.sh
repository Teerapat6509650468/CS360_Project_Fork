#!/bin/bash
# Update and install Docker
sudo apt-get update -y
sudo apt-get install -y docker.io

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# ตรวจสอบว่า Docker ทำงานได้หรือไม่
sudo systemctl status docker || exit 1

# Pull Docker image 
docker pull myapp:latest

# Run the application in a Docker container
docker run -d -p 80:80 myapp:latest

# ตรวจสอบว่า container ทำงานหรือไม่
docker ps
