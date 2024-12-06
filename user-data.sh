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

# Add the ec2-user to the docker group so they can use Docker without sudo
sudo groupadd docker
sudo usermod -aG docker ubuntu

# Fetch the instance's Public IPv4 address using EC2 metadata
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
IPV4=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/public-ipv4)

# Create the .env file with secrets and the public IPv4
cat <<EOT > /home/ubuntu/.env
HOST=0.0.0.0
PORT=1337
PUBLIC_IPV4=$PUBLIC_IPV4
APP_KEYS={{APP_KEYS}}
API_TOKEN_SALT={{API_TOKEN_SALT}}
ADMIN_JWT_SECRET={{ADMIN_JWT_SECRET}}
TRANSFER_TOKEN_SALT={{TRANSFER_TOKEN_SALT}}
JWT_SECRET={{JWT_SECRET}}
EOT

# Confirm that the .env file has been updated
echo "Updated .env with EC2 IPv4: $IPV4"

# Pull and run the Docker containers for the React and Strapi applications
docker pull teerapat1811/react-app:latest
docker pull teerapat1811/strapi-app:latest

docker run -d -p 3000:3000 --name react-app -v /home/ubuntu/.env:/app/.env teerapat1811/react-app:latest
docker run -d -p 1337:1337 --name strapi-app -v /home/ubuntu/.env:/app/.env teerapat1811/strapi-app:latest

# Print the status of the running Docker containers
docker ps

