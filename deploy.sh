#!/bin/bash

REPO_URL="https://github.com/Kwandao6509650245/CS360_Project.git"
URL="localhost"

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