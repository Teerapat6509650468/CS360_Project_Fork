# CS360 1/2567 Term Project: FurEveryHome 

## Group Information

- **Group Name:** Riyal or Fakay? (draft) 

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
- Feature 5: (draft)

### Technologies Used
- **Backend:** Strapi V4 ([Pet Adoption Backend](https://github.com/hubertnare/pet-adoption-backend.git))
- **Frontend:** React.js 
- **Hosting/Deployment:** AWS EC2
- **Database:**  SQLite

The backend for this project is based on the Pet Adoption Backend developed by Hubertnare, which is built using Strapi V4. We appreciate their contribution and have integrated their solution into our project.

## System Requirements

1. Git installation
2. Node.js installation (Version 12.x.x - 16.x.x) 
- npm: installed automatically with Node.js
- yarn : for faster package management
 

## How to deploy and run the project manually (draft)

1. Open terminal
2. connect to the EC2 instance
3. install Node.js, Git, and Yarn
```bash
sudo apt update
sudo apt install git
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install -y nodejs
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install --no-install-recommends yarn
git --version && node -v && yarn --version
```
4. clone the project from GitHub
```bash   
git clone https://github.com/Kwandao6509650245/CS360_Project.git
```
5. change to the project folder
```bash
cd CS360_Project/backend
```
6. build and run backend
```bash
yarn
yarn build
yarn start
```
7. open a new terminal
8. connect to the same EC2 instance
9. change to the project folder
```bash
cd CS360_Project
```
10. create .evn and copy script from .env.example
 ```bash
nano .evn
```   
11. build and run the frontend
```bash
yarn
yarn build
yarn start
```
## How to deploy and run the project using the provided bash script [Specify the bash script path in the repo] 
1.
2.
3.

ภาพ screen capture ของหน้าเว็บแอปพลิเคชันซึ่ง deploy ไว้บน EC2
![ภาพ screen capture ของหน้าเว็บแอปพลิเคชันซึ่ง deploy ไว้บน EC2](https://github.com/user-attachments/assets/ed95ded1-f72c-4cad-9fbc-fa325ba86a68)



