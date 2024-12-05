#!/bin/bash
cd home/ubuntu

sudo apt update
sudo apt install docker.io -y

sudo service docker start
sudo systemctl enable docker

sudo usermod -aG docker ubuntu
newgrp docker

sudo docker pull ${{ secrets.DOCKER_USERNAME }}/pet_adopt_frontend
sudo docker run -d -p 3000:3000 --name cs360_frontend_container meawrage/pet_adopt_frontend:latest

sudo docker pull ${{ secrets.DOCKER_USERNAME }}/pet_adopt_backend
sudo docker run -d -p 1337:1337 --name cs360_backend_container meawrage/pet_adopt_backend:latest
