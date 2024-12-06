#!/bin/bash

# Update the package manager and install Docker
# Add Docker's official GPG key:
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start Docker service and enable it to start on boot
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Add the ubuntu user to the docker group so they can use Docker without sudo
sudo groupadd docker
sudo usermod -aG docker ubuntu

# Fetch the instance's Public IPv4 address using EC2 metadata
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
IPV4=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/public-ipv4)

# Update the .env file with environment variables (GitHub secrets replaced here)
echo "HOST=0.0.0.0" >> /home/ubuntu/.env
echo "PORT=1337" >> /home/ubuntu/.env
echo "APP_KEYS=${APP_KEYS}" >> /home/ubuntu/.env
echo "API_TOKEN_SALT=${API_TOKEN_SALT}" >> /home/ubuntu/.env
echo "ADMIN_JWT_SECRET=${ADMIN_JWT_SECRET}" >> /home/ubuntu/.env
echo "TRANSFER_TOKEN_SALT=${TRANSFER_TOKEN_SALT}" >> /home/ubuntu/.env
echo "JWT_SECRET=${JWT_SECRET}" >> /home/ubuntu/.env
echo "PUBLIC_IPV4=${IPV4}" >> /home/ubuntu/.env

# Confirm that the .env file has been updated
echo "Updated .env with EC2 IPv4: $IPV4"

# Pull and run the Docker containers for the React and Strapi applications
# React app
sudo docker run -d -p 3000:3000 --name react-app \
  -e REACT_APP_BASE_URL=${IPV4} \
  -e HOST=0.0.0.0 \
  -e PORT=3000 \
  -e APP_KEYS=${APP_KEYS} \
  -e API_TOKEN_SALT=${API_TOKEN_SALT} \
  -e ADMIN_JWT_SECRET=${ADMIN_JWT_SECRET} \
  -e TRANSFER_TOKEN_SALT=${TRANSFER_TOKEN_SALT} \
  -e JWT_SECRET=${JWT_SECRET} \
  teerapat1811/react-app:latest

# Strapi app
sudo docker run -d -p 1337:1337 --name strapi-app \
  -e REACT_APP_BASE_URL=${IPV4} \
  -e HOST=0.0.0.0 \
  -e PORT=1337 \
  -e APP_KEYS=${APP_KEYS} \
  -e API_TOKEN_SALT=${API_TOKEN_SALT} \
  -e ADMIN_JWT_SECRET=${ADMIN_JWT_SECRET} \
  -e TRANSFER_TOKEN_SALT=${TRANSFER_TOKEN_SALT} \
  -e JWT_SECRET=${JWT_SECRET} \
  teerapat1811/strapi-app:latest

# Print the status of the running Docker containers
docker ps

# Output the instance's public IP and message
echo "Deployment completed. React and Strapi apps are running on EC2 instance with Public IPv4: $IPV4"
