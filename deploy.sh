#!/bin/bash

REPO_URL="https://github.com/Kwandao6509650245/CS360_Project.git"
URL="localhost"

echo "Update the System."
sudo apt update -y

# Function to check for Git installation
installGit() {
  echo "Checking Git..."
  if ! command -v git &> /dev/null; then
    echo "Git not found."
    sudo apt install git
  else
    echo "Git is already installed."
  fi
}

# Function to install NVM
installNvm() {
  if ! command -v nvm &> /dev/null; then  # Check if NVM is installed first
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    source ~/.bashrc  # Source the profile to load NVM
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
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

installYarn() {
  if ! command -v yarn &> /dev/null; then  # Check if NVM is installed first
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update
    sudo apt install --no-install-recommends yarn
  else
    echo "NVM is already installed."
  fi

}

installPM2() {
  if ! command -v pm2 &> /dev/null; then
    echo "installing pm2"
    npm install pm2 -g
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
    local current_dir=$(pwd)
    echo "Configuring ecosystem.config.js file..."
    pm2 init

    echo "Creating ecosystem.config.js..."
    cat <<EOL > ecosystem.config.js
	module.exports = {
	  apps: [
	    {
	      name: 'pet-adoption-backend',
	      cwd: '$current_dir/backend',
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
installYarn
installPM2
ProjectSetup

echo "Script completed!"