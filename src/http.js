import axios from 'axios';
require('dotenv').config({ path: '../backend/.env'});

const ipAddress = process.env.IP_ADDRESS || 'localhost';
const port = process.env.PORT || 1337;

export default axios.create({

    baseURL: "http://" + ipAddress + ":" + port + "/",
    headers: {
        "Content-type": "application/json"
    }
});
