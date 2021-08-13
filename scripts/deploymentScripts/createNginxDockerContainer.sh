#!/bin/bash
sudo docker pull nginx:latest
sudo docker run -v /home/ubuntu:/home/web --name nginx-assignment -p 8080:80 -d nginx