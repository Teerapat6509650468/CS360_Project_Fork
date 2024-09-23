#!/bin/bash


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

echo "checking package.."
installGit
installNvm
installNode16
installYarn
installPM2