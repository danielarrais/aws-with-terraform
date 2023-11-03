#! /bin/bash

# Install Docker
sudo dnf update -y
sudo dnf install docker -y

# Auto start Docker when starting the machine
sudo systemctl start docker
sudo systemctl enable docker

# Start nginx container
sudo docker run -it --rm -d -p 80:80 --name web nginxdemos/hello