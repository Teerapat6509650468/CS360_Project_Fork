#!/bin/bash
# Update and install Docker
sudo apt-get update -y
sudo apt-get install -y docker.io

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Run the application in a Docker container
docker run -d -p 80:80 <your-docker-image>
