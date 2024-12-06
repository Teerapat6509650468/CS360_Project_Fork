#!/bin/bash

# Update the package manager and install Docker
sudo yum update -y
sudo yum install -y docker

# Start Docker service and enable it to start on boot
sudo service docker start
sudo systemctl enable docker

# Add the ec2-user to the docker group so they can use Docker without sudo
sudo usermod -aG docker ec2-user

# Fetch the instance's Public IPv4 address using EC2 metadata
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
IPV4=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/public-ipv4)

# Write the EC2 public IPv4 address to the .env file
echo "REACT_APP_BASE_URL=http://${IPV4}:1337/" > /home/ec2-user/.env

# Update the .env file with environment variables (GitHub secrets replaced here)
echo "HOST=0.0.0.0" >> /home/ec2-user/.env
echo "PORT=1337" >> /home/ec2-user/.env
echo "APP_KEYS=${APP_KEYS}" >> /home/ec2-user/.env
echo "API_TOKEN_SALT=${API_TOKEN_SALT}" >> /home/ec2-user/.env
echo "ADMIN_JWT_SECRET=${ADMIN_JWT_SECRET}" >> /home/ec2-user/.env
echo "TRANSFER_TOKEN_SALT=${TRANSFER_TOKEN_SALT}" >> /home/ec2-user/.env
echo "JWT_SECRET=${JWT_SECRET}" >> /home/ec2-user/.env
echo "PUBLIC_IPV4=${IPV4}" >> /home/ec2-user/.env

# Confirm that the .env file has been updated
echo "Updated .env with EC2 IPv4: $IPV4"

# Pull and run the Docker containers for the React and Strapi applications
sudo docker run -d -p 3000:3000 --name react-app -v /home/ec2-user/.env:/app/.env teerapat1811/react-app:latest

sudo docker run -d -p 1337:1337 --name strapi-app -v /home/ec2-user/.env:/app/.env teerapat1811/strapi-app:latest

# Print the status of the running Docker containers
docker ps
