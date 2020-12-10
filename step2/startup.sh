sleep 25
sudo apt-get update
sudo apt-get -y updgrade
sudo apt-get -y install nginx jq
sudo rm /var/www/html/index.nginx-debian.html
PUBLIC_IPV4=$(curl -H "metadata:true" http://169.254.169.254/metadata/instance?api-version=2020-09-01 | jq '.network.interface[0].ipv4.ipAddress[0].publicIpAddress')
HOSTNAME=$(curl -H "metadata:true" http://169.254.169.254/metadata/instance?api-version=2020-09-01 | jq '.compute.name')
sudo echo "<h1> Hello from Virtual Machine $HOSTNAME, with IP Address: $PUBLIC_IPV4</h1>" > ./index.nginx-debian.html
sudo chown root:root index.nginx-debian.html
sudo cp ./index.nginx-debian.html /var/www/html/index.nginx-debian.html
sudo systemctl restart nginx
