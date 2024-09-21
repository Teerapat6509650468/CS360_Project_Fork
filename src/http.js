import axios from 'axios';

var url="34.239.126.140";

export default axios.create({

    baseURL: "http://" + url +":1337/",
    headers: {
        "Content-type": "application/json"
    }
});