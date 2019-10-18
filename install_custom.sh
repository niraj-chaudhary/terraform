#!/bin/bash
sudo apt-get -y update
sudo apt-get remove -y awscli
sudo apt-get install -y python-pip
sudo pip install awscli
sudo apt-get -y install ruby
cd /home/ubuntu
wget https://aws-codedeploy-us-west-2.s3.us-west-2.amazonaws.com/latest/install
chmod +x install
sudo ./install auto
sudo service codedeploy-agent start
mkdir /home/ubuntu/deploy
mkdir /home/ubuntu/logs
sudo docker run -d \
--name=filebeat \
--user=root \
--network=host \
--volume="/home/ubuntu/:/home/ubuntu/:ro" \
--volume="/home/ubuntu/filebeat/filebeat.yml:/usr/share/filebeat/filebeat.yml:ro" \
--volume="/var/run/docker.sock:/var/run/docker.sock:ro" \
docker.elastic.co/beats/filebeat:6.6.1 filebeat -e 
