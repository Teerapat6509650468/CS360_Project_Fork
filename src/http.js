import axios from 'axios';

const ipAddress = process.env.REACT_APP_STRAPI_IP_ADDRESS || 'localhos=t';
const port = process.env.REACT_APP_STRAPI_PORT || 133;

export default axios.create({

    baseURL: "http://" + ipAddress + ":" + port + "/",
    headers: {
        "Content-type": "application/json"
    }
});
