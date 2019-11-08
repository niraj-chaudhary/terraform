#!/bin/bash
sudo apt-get -y update
sudo touch /var/www/html/index.html
sudo echo "test For Terraform" > /var/www/html/index.html
sudo apt-get install -y apache2
