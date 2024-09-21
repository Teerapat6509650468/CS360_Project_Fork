
import axios from 'axios';

// Function to get the public IP
const getIP = async () => {
    const ip = (await axios.get('https://api.ipify.org?format=json')).data.ip;
    return ip;
};

// Function to create Axios instance after fetching the IP
const createAxiosInstance = async () => {
    const ip = await getIP();
    return axios.create({
        baseURL: `http://${ip}:1337/`,  // Use the fetched IP here
        headers: {
            "Content-type": "application/json"
        }
    });
};

export default createAxiosInstance;
