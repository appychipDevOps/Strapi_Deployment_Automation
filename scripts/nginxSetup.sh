#!/bin/bash
echo '>> CONFIGURING NGINX SETUP.....'
sudo apt-get update
sudo apt-get -y install nginx
sudo systemctl start nginx
ip=$(curl ifconfig.me)
sudo chown -R ubuntu:ubuntu /etc/nginx/sites-available/
cat > /etc/nginx/sites-available/strapi <<EOF
server {
    listen 80;
    server_name $ip;

    location / {
        include proxy_params;
        proxy_pass http://127.0.0.1:1337;
    }
}
EOF
sudo ln -s /etc/nginx/sites-available/strapi /etc/nginx/sites-enabled/
sudo systemctl restart nginx
echo '<<<   NGINX SETUP DONE   >>>'
