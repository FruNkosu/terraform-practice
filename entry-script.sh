#!/bin/bash
sudo yum update -y && sudo yum install -y docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user
docker run -p 8080:80 nginx
docker run -p 7000:8080 jenkins
docker run -p 6000:9000 sonarqube
            