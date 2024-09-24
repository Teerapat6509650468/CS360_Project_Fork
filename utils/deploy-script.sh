#!/bin/bash

source ~/.bashrc

REPO_URL="https://github.com/Kwandao6509650245/CS360_Project.git"
URL="localhost"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}=============================="
echo -e "   Starting installation...   "
echo -e "==============================${NC}"
sudo apt update -y

# Function to check for Git installation
installGit() {

  if ! command -v git &> /dev/null; then
    echo -e "${YELLOW}git not found. Installing git...${NC}"
    sudo apt install git
    echo -e "${GREEN}git installed successfully!${NC}"
  else
    echo -e "${GREEN}git is already installed.${NC}"
  fi
}

# Function to install NVM
installNvm() {
  if ! command -v nvm &> /dev/null; then  # Check if NVM is installed first
    echo -e "${YELLOW}nvm not found. Installing nvm...${NC}"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    echo -e "${GREEN}nvm installed successfully!${NC}"
  else
    echo -e "${GREEN}nvm is already installed.${NC}"
  fi
}

# Function to install Node.js version 16
installNode16() {
  if command -v node &> /dev/null; then
    NODE_VERSION=$(node -v | grep -o '^v16')
    if [ "$NODE_VERSION" = "v16" ]; then
      echo -e "${GREEN}Node.js v16 is already installed.${NC}"
    else
      echo -e "${YELLOW}Node.js is installed but not v16. Installing Node.js v16...${NC}"
      nvm install 16
      nvm use 16
      echo -e "${GREEN}Node.js v16 installed successfully!${NC}"
    fi
  else
    echo -e "${YELLOW}Node.js not found. Installing Node.js v16...${NC}"
    nvm install 16
    nvm use 16
    echo -e "${GREEN}Node.js v16 installed successfully!${NC}"
  fi
}

installYarn() {
  if ! command -v yarn &> /dev/null; then  
    echo -e "${YELLOW}yarn not found. Installing yarn...${NC}"
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update
    sudo apt install --no-install-recommends yarn
    echo -e "${GREEN}yarn installed successfully!${NC}"
  else
    echo -e "${GREEN}yarn is already installed.${NC}"
  fi

}

installPM2() {
  if ! command -v pm2 &> /dev/null; then
    echo -e "${YELLOW}pm2 not found. Installing pm2...${NC}"
    echo "installing pm2"
    npm install pm2 -g
    echo -e "${GREEN}pm2 installed successfully!${NC}"
  else
    echo -e "${GREEN}pm2 is already installed.${NC}"
  fi
}

frontendSetup() {
echo -e "${CYAN}Installing frontend dependencies...${NC}"
yarn
}

backendSetup() {
echo -e "${CYAN}Installing backend dependencies...${NC}"
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
  echo -e "${CYAN}Cloning project repository...${NC}"
  git clone $REPO_URL

  cd CS360_Project
  frontendSetup
  backendSetup
  projectConfig
  configPM2
  deploy
}

# Call the functions in the desired order

installGit
installNvm
installNode16
installYarn
installPM2
ProjectSetup

echo -e "${GREEN}=============================="
echo -e "   COMPLETED!!!   "
echo -e "==============================${NC}"