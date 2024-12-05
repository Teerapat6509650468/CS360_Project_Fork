import axios from 'axios';

var url = "18.212.221.56";

export default axios.create({

    baseURL: "http://" + url + ":1337/",
    headers: {
        "Content-type": "application/json"
    }
});
