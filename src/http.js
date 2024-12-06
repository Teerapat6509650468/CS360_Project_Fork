import axios from 'axios';

var ipAddress = process.env.PUBLIC_IPV4 || 'localhost';
var port = 1337;

export default axios.create({

    baseURL: "http://" + ipAddress + ":" + port + "/",
    headers: {
        "Content-type": "application/json"
    }
});
