#!/bin/bash

apt update -y
apt upgrade -y

apt install nginx -y

cat > /etc/nginx/sites-available/vproapp <<'EOF'
upstream vproapp {
    server app01:8080;
}

server {
    listen 80;

    location / {
        proxy_pass http://vproapp;
    }
}
EOF

rm -f /etc/nginx/sites-enabled/default

ln -s /etc/nginx/sites-available/vproapp /etc/nginx/sites-enabled/vproapp

systemctl restart nginx
systemctl enable nginx