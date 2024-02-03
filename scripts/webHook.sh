#!/bin/bash

# Set the secret key
secret=$1

# Create the file
cat > /home/ubuntu/webhook.js << EOF
var secret = '${secret}'; 
var repo = '/home/ubuntu/strapiApp/'; 

const http = require('http');
const crypto = require('crypto');
const exec = require('child_process').exec;

const PM2_CMD = 'cd ~ && /home/ubuntu/.nvm/versions/node/v16.20.0/bin/pm2 restart all';

http
  .createServer(function(req, res) {
    req.on('data', function(chunk) {
      let sig =
        'sha1=' +
        crypto
          .createHmac('sha1', secret)
          .update(chunk.toString())
          .digest('hex');

      if (req.headers['x-hub-signature'] == sig) {
        exec(\`cd \${repo} && git pull && \${PM2_CMD}\`, (error, stdout, stderr) => {
          if (error) {
            console.error(\`exec error: \${error}\`);
            return;
          }
          console.log(\`stdout: \${stdout}\`);
          console.log(\`stderr: \${stderr}\`);
        });
      }
    });

    res.end();
  })
  .listen(8080);
EOF


sudo bash -c 'cat > /etc/systemd/system/webhook.service <<EOF
[Unit]
Description=Github webhook
After=network.target

[Service]
Environment=PATH=/usr/bin:/usr/local/bin:/usr/sbin:/usr/local/sbin:/home/ubuntu/.nvm/versions/node/v16.20.0/bin:$PATH
Type=simple
User=ubuntu 
ExecStart=/home/ubuntu/.nvm/versions/node/v16.20.0/bin/node /home/ubuntu/webhook.js
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF'


sudo systemctl enable webhook.service
sudo systemctl start webhook