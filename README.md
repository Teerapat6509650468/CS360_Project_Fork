# CS360 1/2567 Term Project: FurEveryHome 

## Group Information

- **Group Name:** Riyal or Fakay?  

## Members
| name                    | student ID |
| ----------------------- | ---------- |
| Panapol  Junjerm        | 6509650146 | <br> |
| Kwandao  Khunburee      | 6509650245 | <br> |
| Punnapa  Triratdilokkul | 6509650559 | <br> |
| Teerapat Kirdpaiboon    | 6509650468 | <br> |

## Project Goal
The web application serves as a platform for managing and facilitating pet adoptions. It allows users to easily create, view, and manage pet profiles, including details such as name, age, species, breed, location and gender. By providing an organized and intuitive interface for handling pet information, the application enhances the pet adoption process, making it more efficient for both potential adopters and shelters. The goal is to connect pets with their future families more effectively and to support shelters in managing their adoption processes seamlessly. 

### Features
- Feature 1: Dark/Light Mode Toggle 
- Feature 2: User Feedback Notification System for Successful Pet Addition, Editing, and Deletion Actions 
- Feature 3: Enhanced Dropdown Menu for Gender and Animal Species Selection 
- Feature 4: Enhanced Age Input with Validation, Month Support, and Unknown Age Option 


### Technologies Used
- **Backend:** Strapi V4 ([Pet Adoption Backend](https://github.com/hubertnare/pet-adoption-backend.git))
- **Frontend:** React.js 
- **Hosting/Deployment:** AWS EC2
- **Database:**  SQLite

The backend for this project is based on the Pet Adoption Backend developed by Hubertnare, which is built using Strapi V4. We appreciate their contribution and have integrated their solution into our project.

## Setting Up an EC2 Instance

1. Log in to AWS Console
2. Launch a new EC2 instance <br>
 **Application and OS Images** : Ubuntu Server 24.04 LTS (HVM), SSD Volume Type <br>
  **Instance type** : t2.medium  <br>
  **Network setting** : create security group  <br>
-   Type:  `SSH`,  Protocol:  `TCP`,  Port Range  `22`,  Source:  `::/0`
-   Type:  `HTTP`,  Protocol:  `TCP`,  Port Range  `80`,  Source:  `0.0.0.0/0, ::/0`
-   Type:  `HTTPS`,  Protocol:  `TCP`,  Port Range  `443`,  Source:  `0.0.0.0/0, ::/0`
-   Type:  `Custom TCP`,  Protocol:  `TCP`,  Port Range  `1337`,  Source:  `0.0.0.0/0`
-   Type:  `Custom TCP`,  Protocol:  `TCP`,  Port Range  `3000`,  Source:  `0.0.0.0/0`


## System Requirements

1. Git installation
2. Node.js installation (version 12.x.x - 16.x.x) 
- npm: installed automatically with Node.js (version 8.19.4)
- yarn : for faster package management (version 1.22.22)
3. PM2 is included in the deployment through a Bash script. (version 5.4.2)
  
## How to deploy and run the project manually 

**1. Connect to EC2 Instance**
- Open terminal and connect to EC2 instance using SSH :
```bash
ssh -i <your-key.pem> ec2-user@<your-ec2-instance-ip>
```

**2. Check if Git, Node.js, and Yarn are Installed**
- Verify if Git, Node.js, and Yarn are already installed :
```bash
git --version
node -v
yarn --version
```
- If any of these commands return an error or indicate they aren’t installed, proceed to the next step to install them.
  
**3. Install Node.js, Git, and Yarn (if not already installed)**
- Update the package list :
```bash
sudo apt update
```
- Install Git :
```bash
sudo apt install git
```
- Install Node.js (version 16.x.x) :
```bash
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install -y nodejs
```
- Install Yarn :
```bash
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install --no-install-recommends yarn
```
**4. Verify Installations**
- After installation, verify that Git, Node.js, and Yarn have been installed successfully by running :
```bash
git --version && node -v && yarn --version
```
**5. Clone the Project from GitHub**
- Clone the repository :
```bash
git clone https://github.com/Kwandao6509650245/CS360_Project.git
```
**6. Set Up the Backend**
- Change to the backend directory :
```bash
cd CS360_Project/backend
```
- Create or modify the .env file and copy the content from .env.example :
```bash
cp .env.example .env
```
- Generate Secret Keys <br>
Use the following command to generate 6 secret keys :
```bash
#generated_key1
openssl rand -base64 32
#generated_key2
openssl rand -base64 32
#generated_key3
openssl rand -base64 32
#generated_key4
openssl rand -base64 32
#generated_key5
openssl rand -base64 32
#generated_key6
openssl rand -base64 32
```
- Update the .env file <br>
After generating the secret keys, replace the toBeModified placeholders in the .env file :
```bash
#open .env file for modify
nano .env
```
```bash
#Copy the 6 generated secret keys from the previous step 
HOST=0.0.0.0
PORT=1337
APP_KEYS="generated_key1,generated_key2"
API_TOKEN_SALT=generated_key3
ADMIN_JWT_SECRET=generated_key4
TRANSFER_TOKEN_SALT=generated_key5
JWT_SECRET=generated_key6
```
**7. Build and Run the Backend**
- Install dependencies, build and start the backend server :
```bash
yarn
yarn build
yarn start
```
**8. Set Up the Frontend**
- Open a new terminal and connect to the same EC2 instance. 
- Change to the project directory and Change the IP address in http.js Before building the frontend, open the http.js file and update the url variable with the public IP of your EC2 instance :
```bash
cd CS360_Project/src
nano http.js
```
- Replace old IP address (line 3) with your EC2 instance's public IP (e.g., "your-ec2-public-ip") and then
save and exit the editor (for nano, use CTRL + o, Enter, then  CTRL + x) :
```javascript
var url="your-ec2-public-ip";
```
**9. Build and Run the Frontend**
- Install dependencies, build and start the Frontend server :
```bash
yarn
yarn build
yarn start
```
**10. Access the Backend and Frontend**
- Once both the backend and frontend are running, you can access them via your web browser.
- Open frontend :
```
http://<your-ec2-public-ip>:3000
```
- Open backend :
```
http://<your-ec2-public-ip>:1337
```
- Replace <your-ec2-public-ip> with the actual public IP address of your EC2 instance.

**11. Enable API in Strapi** <br>
By following these steps, you will be able to create, update, delete, and view data through the API without requiring authentication. <br>

- Access the Strapi Admin Panel
Open your browser and navigate to the Strapi Admin Panel, typically found at `http://<your-ec2-public-ip>:1337/admin` or another URL where your Strapi instance is running.

- Go to the Settings Menu
Once in the Admin Panel, click on the `Settings` option in the left sidebar.

- Select the User & Permissions Plugin
In the Settings page, find and click on the `User & Permissions Plugin` under the `PLUGIN` section.

- Click on Roles
After selecting the User & Permissions Plugin, choose the `Roles` submenu. This will show a list of roles within Strapi.

- Choose the Public Role
From the list of roles, select the `Public` role, which governs permissions for users who do not log in or register.

- Configure Permissions
After selecting the Public role, you will see a list of available API permissions.

  - Scroll down to the API `Pet` to enable for public access.
  - Tick the box for `Select All` to allow public access to all actions within that API.
  
- Save Changes
Once you have configured the permissions as needed, click the `Save` button in the lower-right corner to apply the changes.
  
## How to deploy and run the project using the provided bash script [Specify the bash script path in the repo]

Follow these steps to deploy and run the project using the provided bash script. Ensure you are connected to your EC2 instance before proceeding. <br>

**1. Connect to EC2 Instance**
- Open terminal and connect to EC2 instance using SSH :
```bash
ssh -i <your-key.pem> ec2-user@<your-ec2-instance-ip>
```

**2. Set Up the Bash Script** 

There are two scenarios to set up and run the bash script. You can either use an existing repository, or clone it automatically within the script.

**Option 1: Use the Existing Cloned Repository** <br>
If you have already cloned the repository, follow these steps <br><br>
**1. Set up and run the script**
- Navigate to the utils/ directory :
```bash
cd CS360_Project/utils/
```
- Change permission deploy-script.sh and run script :
```bash
chmod +x deploy-script.sh
source deploy-script.sh
```

**2. Access the Backend and Frontend**
- Once both the backend and frontend are running, you can access them via your web browser.
- Open frontend :
```
http://<your-ec2-public-ip>:3000
```
- Open backend :
```
http://<your-ec2-public-ip>:1337
```
- Replace <your-ec2-public-ip> with the actual public IP address of your EC2 instance.

**3. Enable API in Strapi** <br>
By following these steps, you will be able to create, update, delete, and view data through the API without requiring authentication. <br>

- Access the Strapi Admin Panel
Open your browser and navigate to the Strapi Admin Panel, typically found at `http://<your-ec2-public-ip>:1337/admin` or another URL where your Strapi instance is running.

- Go to the Settings Menu
Once in the Admin Panel, click on the `Settings` option in the left sidebar.

- Select the User & Permissions Plugin
In the Settings page, find and click on the `User & Permissions Plugin` under the `PLUGIN` section.

- Click on Roles
After selecting the User & Permissions Plugin, choose the `Roles` submenu. This will show a list of roles within Strapi.

- Choose the Public Role
From the list of roles, select the `Public` role, which governs permissions for users who do not log in or register.

- Configure Permissions
After selecting the Public role, you will see a list of available API permissions.

  - Scroll down to the API `Pet` to enable for public access.
  - Tick the box for `Select All` to allow public access to all actions within that API.
  
- Save Changes
Once you have configured the permissions as needed, click the `Save` button in the lower-right corner to apply the changes.

<hr>

**Option 2: Clone the Repository Automatically and Run the Script** <br>
If you prefer to clone the repository automatically as part of the script, follow these steps to create and set up the deploy-script.sh <br><br>

**1. Set up the bash script**
- Create and edit the deploy-script.sh file : 
```bash
touch deploy-script.sh
chmod +x deploy-script.sh
nano deploy-script.sh
```

- Add the following script to the file (or copy it from utils/deploy-script.sh) :
```bash
#!/bin/bash

source ~/.bashrc

REPO_URL="https://github.com/Kwandao6509650245/CS360_Project.git"
public_ip=$(curl -s http://checkip.amazonaws.com)

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
sed -i "s/var url=\"[^\"]*\";/var url=\"$public_ip\";/g" http.js
cd ..
cd backend
generate_secret_key() {
    openssl rand -base64 32
}

# Define the path to your .env file
ENV_FILE=".env"

# Create the .env file or clear the existing content
echo "Creating or overwriting the .env file..."
> $ENV_FILE

# Populate the .env file with secret keys
echo "HOST=0.0.0.0" >> $ENV_FILE
echo "PORT=1337" >> $ENV_FILE
echo 'APP_KEYS="'"$(generate_secret_key)"','"$(generate_secret_key)"'"' >> $ENV_FILE
echo "API_TOKEN_SALT=$(generate_secret_key)" >> $ENV_FILE
echo "ADMIN_JWT_SECRET=$(generate_secret_key)" >> $ENV_FILE
echo "TRANSFER_TOKEN_SALT=$(generate_secret_key)" >> $ENV_FILE
echo "JWT_SECRET=$(generate_secret_key)" >> $ENV_FILE

echo ".env file generated with secret keys."
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
```

**2. Run the bash script**
- Execute the script :
```bash
source deploy-script.sh
```
**3. Access the Backend and Frontend**
- Once both the backend and frontend are running, you can access them via your web browser.
- Open frontend :
```
http://<your-ec2-public-ip>:3000
```
- Open backend :
```
http://<your-ec2-public-ip>:1337
```
- Replace <your-ec2-public-ip> with the actual public IP address of your EC2 instance.

**4. Enable API in Strapi** <br>
By following these steps, you will be able to create, update, delete, and view data through the API without requiring authentication. <br>

- Access the Strapi Admin Panel
Open your browser and navigate to the Strapi Admin Panel, typically found at `http://<your-ec2-public-ip>:1337/admin` or another URL where your Strapi instance is running.

- Go to the Settings Menu
Once in the Admin Panel, click on the `Settings` option in the left sidebar.

- Select the User & Permissions Plugin
In the Settings page, find and click on the `User & Permissions Plugin` under the `PLUGIN` section.

- Click on Roles
After selecting the User & Permissions Plugin, choose the `Roles` submenu. This will show a list of roles within Strapi.

- Choose the Public Role
From the list of roles, select the `Public` role, which governs permissions for users who do not log in or register.

- Configure Permissions
After selecting the Public role, you will see a list of available API permissions.

  - Scroll down to the API `Pet` to enable for public access.
  - Tick the box for `Select All` to allow public access to all actions within that API.
  
- Save Changes
Once you have configured the permissions as needed, click the `Save` button in the lower-right corner to apply the changes.

***
  
ภาพ screen capture ของหน้าเว็บแอปพลิเคชันซึ่ง deploy ไว้บน EC2

![Screenshot 2024-09-21 205426](https://github.com/user-attachments/assets/489a9f86-c1af-4c7d-99d5-5bac137d5aab)


## Unit and Integration Testing Overview
Our team uses the following tools for testing :
- **Jest**: Used for unit testing individual functions or modules, ensuring that each component works as expected in isolation.
- **Supertest**: Handles integration testing, focusing on how different parts of the application interact, especially useful for testing API endpoints.
- **Babel**: Transpiles ES6+ JavaScript code to ensure compatibility with Jest, allowing the use of modern JavaScript features in tests.
- **GitHub Actions**: Automates testing in CI/CD. Each push and pull request triggers the GitHub Actions workflow, running our test suite in various environments (e.g., macos-latest, ubuntu-24.04). This setup ensures consistent test results across platforms and notifies us immediately if any tests fail, providing valuable feedback on code quality before merging.


## Setting Up Tests

- For local, to set up the testing environment, make sure you have Yarn installed. Then, install the required packages by running:

    ```bash
    yarn 
    ```

- In our project, the CI pipeline automatically runs whenever code is updated (through push or pull requests) in every branch and follows these steps:

    1. **Trigger (on:)**  
       The pipeline automatically runs on any `push` or `pull_request` event to any branch (`'*'`). This ensures the workflow is triggered for all updates across branches.

    2. **Job Setup (Run-Test-Suite)**  
       The job is configured to run on different operating systems using a matrix strategy (`ubuntu-24.04`, `windows-latest`, `macos-latest`), ensuring compatibility across environments. Different Node.js versions (`16.x`, `22.x`, and `node`) are also tested, ensuring the code runs smoothly on multiple versions of Node.js.

    3. **Steps**:
        - **System Information**:
            - `echo "This job is now running on a ${{ matrix.os }}"` outputs the OS currently in use for easier debugging and identification.
            - Displays the branch name and repository using `echo`, showing contextual information for the test.
        
        - **Checkout Code**:  
          Uses `actions/checkout@v4` to pull the latest code from the repository into the runner environment, ensuring the job has the most recent code.
        
        - **Setup Node.js**:  
          - Installs Node.js on the runner according to the specified `matrix.node-version`. The `cache: 'npm'` option is used to save previously downloaded packages and speed up future runs.
        
        - **List Repository Files**:  
          - Lists all files in the repository with `ls`, helping confirm that the code is available and accessible for subsequent steps.
        
        - **Install Dependencies**:  
          - Runs `npm ci` to install all project dependencies as specified in `package-lock.json`, ensuring consistent dependency versions.
        
        - **Run Test Suite**:  
          - Runs `npm test` to execute the automated tests.
          - The environment variables (`APP_KEYS`, `API_TOKEN_SALT`, `ADMIN_JWT_SECRET`, `TRANSFER_TOKEN_SALT`, `JWT_SECRET`) are set using GitHub secrets, securely providing necessary values for tests.
        
        - **If tests fail**, an error is logged specifying which tests failed on each OS and Node.js version.
        
        - **Display Job Status**:  
          - Logs the job’s final status (e.g., success or failure) using `echo`, providing a summary of the job outcome for easier troubleshooting.


## Running Tests
- **Running Tests Locally**: Before pushing code, you can run tests locally with these commands:

```bash
npm test
```
- **CI Pipeline Process**:
  1. Every time there’s a push or pull request to any branch (indicated by '*' in the `.yml` file), the pipeline triggers automatically.
  2. GitHub Actions starts running the Run-Test-Suite job, following each step in sequence: checking out code, setting up the environment, installing dependencies, and running the test suite.
  3. The matrix strategy makes the pipeline test the code across multiple operating systems and Node.js versions, as specified, to confirm compatibility across all environments.


## Test File Structure

The unit test and integration test files in this project are stored in the `src/__test__` folder:

### Unit Tests

**CreatePetEntry.test.js**
- Handles input changes for Create Pet Entry.
- Calls `createNewPet` on button click with correct data.
- Does not call `createNewPet` if required fields are not filled.

**EditPetEntry.test.js**
- Handles input changes for Edit Pet Entry.
- Calls `updatePet` on button click with correct data.
- Should not have the same values as the initial mock repo after editing.

### Integration Tests

**PetIntegration.test.js**
- **Create a New Pet Entry**: Tests POST `/api/pets` to create a new entry and checks the created data.
- **Update a Pet Entry**: Tests PUT `/api/pets/:id` to update an existing pet’s data.
- **Retrieve All Pets**: Tests GET `/api/pets` to retrieve all pet entries.
- **Handle Missing Fields**: Tests POST `/api/pets` with missing data to check for error handling.
- **Retrieve a Pet by ID**: Tests GET `/api/pets/:id` to fetch a specific pet.
- **Delete a Pet Entry**: Tests DELETE `/api/pets/:id` to ensure a pet entry is deleted properly.
- **Handle Non-Existing Pet Requests**: Checks PUT and GET requests for non-existing pet IDs, ensuring proper error responses.

### CI Configuration

The `test-suite.yml` file used for GitHub Actions CI is stored in `.github/workflows`:
- This file is configured to handle CI for our testing pipeline.


## Test Coverage
This repository includes thorough test coverage across two key areas:
- **Unit Testing**: Focuses on individual functions or modules to confirm they work as expected in isolation. Each unit is tested with a range of inputs to ensure reliable and consistent behavior, catching issues early in development.

- **Integration Testing**: Verifies that different parts of the API interact correctly. By testing how modules work together, integration testing ensures data flows smoothly between components, identifying issues that may appear when components are combined.

  As part of our CI setup, every push or pull request automatically triggers the test suite using GitHub Actions (configured in `.github/workflows/test-suite.yml`). This CI process runs both unit and integration tests across multiple environments, providing:

	- **Immediate Feedback**: Notifications alert us to any failed tests, enabling quick fixes and reducing the risk of breaking changes.
	- **Cross-Platform Compatibility**: The CI pipeline runs tests on different operating systems (e.g., `macOS`, `Ubuntu`, `Windows`) and Node.js versions, ensuring consistent performance across environments.

## Viewing Test Results 

You can view test results both in the CI pipeline on GitHub and locally in your terminal. Here’s how:

### 1. Viewing Test Results in GitHub Actions
   - **Go to the Repository on GitHub**:
     - Navigate to your project repository where the CI pipeline is set up.
   - **Access the “Actions” Tab**:
     - In this tab, you’ll see all triggered workflows, such as those from pushes or pull requests.
     - The latest workflow appears at the top with statuses like ✔️ success, ❌ failure, or ⏳ in progress.
   - **Select the Workflow**:
     - Click on the workflow to see its details. This opens a page showing each job created from the `.yml` file (e.g., build).
   - **View the Job Log**:
     - Click on the job (e.g., build) to check logs for each step.
     - Logs show details for steps like dependency installation, test execution, and any errors or failures.
   - **Notifications and Test Reports**:
     - If a test fails, GitHub Actions provides error details, showing which assertions did not pass.

### 2. Viewing Test Results in Terminal (Local Testing)
   - **Run Tests Locally**:
     - Run tests with the command:
     
       ```bash
       npm test
       ```

     - Results will appear in the terminal in real-time.

   - **Test Results**:
     - The terminal shows detailed results, including:
       - Number of tests passed and failed
       - Time taken per test
       - Error details for any failed assertions
   - **Summary**:
     - At the end, the terminal provides a summary, such as `Tests: 10 passed, 2 failed`, giving an overview of the test outcomes.


## Adding New Tests

Add new test files within the `src/__test__` directory, following these steps:

1. **Create Test Files**:
   - For **unit tests**, add files under `src/__test__/unit/`.
   - For **integration tests**, place files under `src/__test__/integration/`.
   - Each test file should follow a naming convention that reflects its purpose. For example:
     - `NewComponent.test.js` for unit tests.
     - `APIEndpointIntegration.test.js` for integration tests.

2. **Write Test Cases**:
   - Define test cases that validate specific functions, components, or API endpoints.
    - Use Jest’s `describe` and `it` functions to organize tests for unit testing.
   - For integration tests with Supertest.

3. **Run Tests Locally**:
   - Ensure that new tests pass locally by running:
     
     ```bash
     npm test
     ```
   - Check that tests produce expected outcomes without breaking existing functionality.

4. **Commit and Push**:
   - After validating new tests locally, select the branch associated with the new test (e.g., `sprint2-unit-test`).
   - Commit and push the code to trigger CI tests in GitHub Actions. This will run the test suite across different environments, reinforcing compatibility and quality.
 
5. **Review Test Results**:
   - Monitor the GitHub Actions workflow to confirm that all tests pass.
  
6. **Merge to Main Branch**:
   - After ensuring that all tests pass successfully, you can merge your branch into the main branch.







  












