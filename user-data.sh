#!/bin/bash

# Update and install Docker
echo "Updating and installing Docker..."
sudo apt-get update -y || exit 1
sudo apt-get install -y docker.io || exit 1

# Start Docker service
echo "Starting Docker service..."
sudo systemctl start docker || exit 1
sudo systemctl enable docker || exit 1

# ตรวจสอบว่า Docker ทำงานได้หรือไม่
echo "Checking Docker status..."
sudo systemctl status docker || exit 1

# ตรวจสอบเวอร์ชั่นของ Docker
docker --version || exit 1

# Pull Docker image
echo "Pulling Docker image 'myapp:latest'..."
docker pull myapp:latest || exit 1

# Run the application in a Docker container
echo "Running Docker container..."
docker run -d -p 80:80 myapp:latest || exit 1

# ตรวจสอบว่า container ทำงานหรือไม่
echo "Checking Docker container status..."
docker ps || exit 1

echo "Docker container is running successfully!"
