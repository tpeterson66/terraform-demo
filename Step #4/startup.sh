#!/bin/bash
#added since the VPS may not fully initilize before we SSH to the server
sleep 25
sudo apt-get update
sudo apt-get -y updgrade
sudo apt-get -y install nginx
HOSTNAME=$(curl -s http://169.254.169.254/metadata/v1/hostname)
PUBLIC_IPV4=$(curl -s http://169.254.169.254/metadata/v1/interfaces/public/0/ipv4/address)
sudo echo Hello from Droplet $HOSTNAME, with IP Address: $PUBLIC_IPV4 > /var/www/html/index.nginx-debian.html