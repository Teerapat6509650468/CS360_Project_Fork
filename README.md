# CS360 1/2567 Term Project: FurEveryHome 

## Group Information

- **Group Name:** Riyal or Fakay?  

## Members

| Panapol  Jumjerm        | 6509650146 | <br>
| Kwandao  Khunburee      | 6509650245 | <br>
| Punnapa  Triratdilokkul | 6509650559 | <br>
| Teerapat Kirdpaiboon    | 6509650468 | <br>

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
2. Node.js installation (Version 12.x.x - 16.x.x) 
- npm: installed automatically with Node.js
- yarn : for faster package management
  
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
**7. Build and Run the Backend**
- Install dependencies, build and start the backend server :
```bash
yarn
yarn build
yarn start
```
**8. Set Up the Frontend**
- Open a new terminal and connect to the same EC2 instance. 
- Change to the project directory and Change the IP address in http.js Before building the frontend, open the http.js file and update the url variable with the public IP of your EC2 instance:
```bash
cd CS360_Project/src/http.js
nano http.js
```
- Replace old IP address with your EC2 instance's public IP (e.g., "your-ec2-public-ip") and then
save and exit the editor (for nano, use CTRL + o, Enter, then  CTRL + x).
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
- Once both the backend and frontend are running, you can access them via your web browser :
- Open frontend :
```
http://<your-ec2-public-ip>:3000
```
- Open backend :
```
http://<your-ec2-public-ip>:1337
```
- Replace <your-ec2-public-ip> with the actual public IP address of your EC2 instance.
  
## How to deploy and run the project using the provided bash script [Specify the bash script path in the repo] 
**1. Connect to EC2 Instance**
- Open terminal and connect to EC2 instance using SSH :
```bash
ssh -i <your-key.pem> ec2-user@<your-ec2-instance-ip>
```
**2. Set Up the Bash Script** 
- Change the URL in deploy.sh url with the public IP of your EC2 instance:
```bash
cd CS360_Project
nano deploy.sh
```
- Replace old IP address (line 4) with your EC2 instance's public IP (e.g., "your-ec2-public-ip") and then
save and exit the editor (for nano, use CTRL + s, then  CTRL + x).
```bash
URL="your-ec2-public-ip"
```
**3. Run the bash script**
- Before running the script, ensure it has executable permissions :
```bash
chmod +x deploy.sh
```
- Execute the script :
```bash
./deploy.sh
```
- If the script requires superuser permissions, prepend it with sudo :
```bash
sudo ./deploy.sh
```
**4. Access the Backend and Frontend**
- Once both the backend and frontend are running, you can access them via your web browser :
- Open frontend :
```
http://<your-ec2-public-ip>:3000
```
- Open backend :
```
http://<your-ec2-public-ip>:1337
```
- Replace <your-ec2-public-ip> with the actual public IP address of your EC2 instance.

***
  
ภาพ screen capture ของหน้าเว็บแอปพลิเคชันซึ่ง deploy ไว้บน EC2

![Screenshot 2024-09-21 205426](https://github.com/user-attachments/assets/489a9f86-c1af-4c7d-99d5-5bac137d5aab)







  












