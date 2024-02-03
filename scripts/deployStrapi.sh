#!/bin/bash

cd /home/ubuntu/strapiApp/
export PATH=$PATH:/home/ubuntu/.nvm/versions/node/v16.20.2/bin
node -v && pm2 -v
npm install
NODE_ENV=production npm run build
pm2 start "npm start"