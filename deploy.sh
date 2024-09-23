#!/bin/bash

REPO_URL="https://github.com/Kwandao6509650245/CS360_Project.git"
URL="localhost"

echo "Update the System."
sudo yum update -y

# Function to check for Git installation
installGit() {
  echo "Checking Git..."
  if ! command -v git &> /dev/null; then
    echo "Git not found."
    sudo yum install git
  else
    echo "Git is already installed."
  fi
}

# Function to install NVM
installNvm() {
  if ! command -v nvm &> /dev/null; then  # Check if NVM is installed first
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    source ~/.bashrc  # Source the profile to load NVM
  else
    echo "NVM is already installed."
  fi
}

# Function to install Node.js version 16
installNode16() {
  nvm install 16
  nvm use 16
  echo "Node.js version 16 installed and activated."
}

installPM2() {
  if ! command -v pm2 &> /dev/null; then
    echo "installing pm2"
    sudo npm install pm2 -g
  else
    echo "pm2 is already installed."
  fi
}

frontendSetup() {
echo "Installing frontend"
yarn
}

backendSetup() {
echo "Installing backend"
cd backend
yarn
cd ..
}

projectConfig() {
cd src
sed -i "s/var url=\"[^\"]*\";/var url=\"$URL\";/g" http.js
cd ..
cd backend
cp .env.example .env
cd ..
}

deploy() {
yarn build
cd backend
yarn build
cd ..
pm2 start ecosystem.config.js
yarn start
}

configPM2() {
    echo "Configuring ecosystem.config.js file..."
    pm2 init

    echo "Creating ecosystem.config.js..."
    cat <<EOL > ecosystem.config.js
	module.exports = {
	  apps: [
	    {
	      name: 'pet-adoption-backend',
	      cwd: '/home/ubuntu/CS360_Project/backend',
	      script: 'npm',
	      args: 'start',
      	env: {
      	  APP_KEYS: process.env.APP_KEYS,
      	  API_TOKEN_SALT: process.env.API_TOKEN_SALT,
      	  ADMIN_JWT_SECRET: process.env.ADMIN_JWT_SECRET,
      	  JWT_SECRET: process.env.JWT_SECRET,
	  NODE_ENV: 'production',
      },
    },
  ],
};
EOL
}

# Function to set up the project
ProjectSetup() {
  echo "Cloning project repository..."
  # Modify directory name if needed (e.g., git clone ... my_project_name)
  git clone $REPO_URL

  cd CS360_Project
  frontendSetup
  backendSetup
  projectConfig
  configPM2
  deploy
}

# Call the functions in the desired order
echo "checking package.."
installGit
installNvm
installNode16
installPM2
ProjectSetup

echo "Script completed!"



