#!/bin/bash
# connect to docker 
sudo docker exec -t nginx-assignment apt-get update -y 
# no sudo needs
sudo docker exec -t nginx-assignment apt-get install nodejs -y 
sudo docker exec -t nginx-assignment apt-get install npm -y  
#copy the config file to override the default one
sudo docker exec -t nginx-assignment cp /home/web/nginxConf/default.conf /etc/nginx/conf.d/ 
#restart docker
sudo docker restart nginx-assignment 
# deploy the node script 
sudo docker exec -t nginx-assignment bash -c "cd /home/web/nodejsScripts/ && npm install"
# add d to make it run from background. Was not working with nohup see https://stackoverflow.com/questions/33732061/why-docker-exec-is-killing-nohup-process-on-exit
sudo docker exec -td nginx-assignment bash -c "cd /home/web/nodejsScripts/ && node index.js"
