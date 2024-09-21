import axios from 'axios';

const ip = (await axios.get('https://api.ipify.org?format=json')).data.ip;
export default axios.create({
    baseURL: `http://${ip}:1337/`,
    headers: {
        "Content-type": "application/json"
    }
});
