#!/bin/bash

public_ip=$(curl -s http://checkip.amazonaws.com)

cd ..
cd src
sed -i "s/var url=\"[^\"]*\";/var url=\"$public_ip\";/g" http.js
