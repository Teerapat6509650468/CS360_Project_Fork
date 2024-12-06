#!/bin/bash
cd home/ubuntu

sudo apt update
sudo apt install docker.io -y

sudo service docker start
sudo systemctl enable docker

sudo usermod -aG docker ubuntu
newgrp docker

sudo docker pull ${{ secrets.DOCKER_USERNAME }}/petadopt_frontend
sudo docker run -d -p 3000:3000 --name cs360_frontend_container ${{ secrets.DOCKER_USERNAME }}/petadopt_frontend:latest

sudo docker pull ${{ secrets.DOCKER_USERNAME }}/petadopt_backend
sudo docker run -d -p 1337:1337 --name cs360_backend_container ${{ secrets.DOCKER_USERNAME }}/petadopt_backend:latest
