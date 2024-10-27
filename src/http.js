import axios from 'axios';

var url="localhost";

export default axios.create({

    baseURL: "http://" + url +":1337/",
    headers: {
        "Content-type": "application/json"
    }
});
